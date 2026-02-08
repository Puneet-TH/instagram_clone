import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/models/user.dart' as model;
import 'package:instagramclone/pages/private_screen.dart';
import 'package:instagramclone/widget/chat_profile.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ChatScreen extends StatefulWidget {
  final snap;
  const ChatScreen({super.key, required this.snap});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    final listOfFollowingFollowers = [
      ...widget.snap.following,
      ...widget.snap.followers
    ].toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen',),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: widget.snap.following.isEmpty
          ? const Center(
              child: Text('No following users'),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid', whereIn: listOfFollowingFollowers)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No users found'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => ChatProfile(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                );
              })
      // body : Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //         ChatProfile()
      //     ],
      //   )
      // )
    );
  }
}
