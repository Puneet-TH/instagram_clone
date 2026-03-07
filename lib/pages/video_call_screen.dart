import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:instagramclone/config/zego_config.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget {
  final String callid;
  final String userid;
  final String username;
  const VideoCallScreen({super.key,
    required this.callid,
    required this.userid,
    required this.username
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
   @override
  Widget build(BuildContext context) {
    return  ZegoUIKitPrebuiltCall(
        appID: ZegoConfig().AppID,
        appSign: ZegoConfig().AppSign,
        callID: widget.callid,
        userID: widget.userid,
        userName: widget.username,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}


