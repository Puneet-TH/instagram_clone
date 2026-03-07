import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../config/zego_config.dart';
class VoiceCallScreen extends StatefulWidget {
  final String callid;
  final String userid;
  final String username;
  const VoiceCallScreen({
    super.key,
    required this.callid,
    required this.userid,
    required this.username
     }
  );

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  @override
  Widget build(BuildContext context) {
    return  ZegoUIKitPrebuiltCall(
        appID: ZegoConfig().AppID,
        appSign: ZegoConfig().AppSign,
        callID: widget.callid,
        userID: widget.userid,
        userName: widget.username,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
    );
  }
}

