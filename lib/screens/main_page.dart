// ignore_for_file: avoid_print, unused_field, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:convert';
import 'package:sdp_transform/sdp_transform.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _localVideoRenderer = RTCVideoRenderer();
  final _remoteVideoRenderer = RTCVideoRenderer();
  final sdpController = TextEditingController();
  bool _offer = false;

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  void initRenderers() async {
    await _localVideoRenderer.initialize();
    await _remoteVideoRenderer.initialize();
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };
    MediaStream mediaStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);

    _localVideoRenderer.srcObject = mediaStream;
  }

  _createPeerConnecion() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };
    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };
    // late MediaStream _localStream;
    _localStream = await _getUserMedia();

    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);

    pc.addStream(_localStream!);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({
          'candidate': e.candidate,
          'sdpMid': e.sdpMid,
          'sdpMlineIndex': e.sdpMLineIndex
        }));
      }
    };

    pc.onIceConnectionState = (e) {
      print(e);
    };

    pc.onAddStream = (stream) {
      print('addStream: ' + stream.id);
      _remoteVideoRenderer.srcObject = stream;
    };
    _peerConnection = pc;
    return pc;
  }

  void _createOffer() async {
    RTCSessionDescription description =
        await _peerConnection!.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    print(json.encode(session));
    _offer = true;
    _peerConnection!.setLocalDescription(description);
  }

  void _createAnswer() async {
    RTCSessionDescription description =
        await _peerConnection!.createAnswer({'offerToReceiveVideo': 1});

    var session = parse(description.sdp.toString());
    print(json.encode(session));

    _peerConnection!.setLocalDescription(description);
  }

  void _setRemoteDescription() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode(jsonString);

    String sdp = write(session, null);

    RTCSessionDescription description =
        RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());

    await _peerConnection!.setRemoteDescription(description);
  }

  void _addCandidate() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode(jsonString);
    print(session['candidate']);
    dynamic candidate = RTCIceCandidate(
        session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection!.addCandidate(candidate);
  }

  @override
  void initState() async {
    initRenderers();
    await _createPeerConnecion();
    // _getUserMedia();
    super.initState();
  }

  @override
  void dispose() async {
    await _localVideoRenderer.dispose();
    sdpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  key: Key('local'),
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  decoration: BoxDecoration(color: Colors.black),
                  child: RTCVideoView(_localVideoRenderer),
                ),
                Container(
                  height: 200,
                  width: 150,
                  key: Key('remote'),
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: RTCVideoView(_remoteVideoRenderer),
                ),
              ],
            ),
            Column(
              children: [
                TextField(
                  controller: sdpController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  maxLength: TextField.noMaxLength,
                ),
                ElevatedButton(
                  onPressed: _createOffer,
                  child: const Text("Offer"),
                ),
                ElevatedButton(
                  onPressed: _createAnswer,
                  child: const Text("Answer"),
                ),
                ElevatedButton(
                  onPressed: _setRemoteDescription,
                  child: const Text("Set Remote Description"),
                ),
                ElevatedButton(
                  onPressed: _addCandidate,
                  child: const Text("Set Candidate"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
