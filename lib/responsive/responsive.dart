import 'package:flutter/material.dart';
import 'package:instagramclone/config/zego_config.dart';
import 'package:instagramclone/utils/global_variable.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../providers/user_provider.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  bool _isLoading = true;
  static bool _zegoInitialized = false;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    final user = _userProvider.getUser;
    if (!_zegoInitialized) {
      _zegoInitialized = true;
      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
      await ZegoUIKitPrebuiltCallInvitationService().init(
          appID: ZegoConfig().AppID,
          appSign: ZegoConfig().AppSign,
          userID: user.uid,
          userName: user.username,
          plugins: [ZegoUIKitSignalingPlugin()]);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose(){
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    _zegoInitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}