import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/resources/firestor_methods.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/comment_card.dart';
import 'package:instagramclone/widget/follow_following_card.dart';
import 'package:instagramclone/widget/liked_by_card.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
class LikedByScreen extends StatefulWidget {
  const LikedByScreen({super.key});

  @override
  State<LikedByScreen> createState() => _LikedByScreenState();
}

class _LikedByScreenState extends State<LikedByScreen> {
  List<Map<String, String>> notificationsList = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    getLikedByArray();
  }
  
  void getLikedByArray() async{
    setState(() {
      isLoading = true;
    });
    
    var likedByUsers = await FirestoreMethods().getLikedByUsers(userId);
    print('this is the getting likes ${likedByUsers}');
    
    List<Map<String, String>> tempNotifications = [];
    
    for (var post in likedByUsers) {
      if (post['likes'] != null && post['likes'] is List) {
        String postUrl = post['postUrl'] ?? '';
        List<dynamic> likes = post['likes'];
        
        // Create a notification entry for each user who liked this post
        for (var likedUserId in likes) {
          tempNotifications.add({
            'userId': likedUserId.toString(),
            'postUrl': postUrl,
          });
        }
      }
    }
    
    setState(() {
      notificationsList = tempNotifications;
      isLoading = false;
    });
    
    print('Total notifications: ${notificationsList.length}');
  }
  
  @override
  Widget build(BuildContext context) {
    print(userId);
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications', style: TextStyle(
              fontSize: 20,
              color: primaryColor
          ),),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notificationsList.isEmpty
                ? const Center(child: Text('No notifications yet'))
                : ListView.builder(
                    itemCount: notificationsList.length,
                    itemBuilder: (context, index){
                      var notification = notificationsList[index];
                      print('User: ${notification['userId']}, Post: ${notification['postUrl']}');
                      return LikedByCard(
                        userId: notification['userId']!,
                        postId: notification['postUrl']!,
                      );
                    })
    );
  }
}

