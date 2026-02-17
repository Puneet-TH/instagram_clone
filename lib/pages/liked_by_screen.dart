import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/follow_following_card.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
class LikedByScreen extends StatelessWidget {
  const LikedByScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(
          fontSize: 20,
          color: primaryColor
        ),),
        centerTitle: true,
      ),
      body: Center(
                child: Text('No posts liked'),
              )
    );

  }
}
