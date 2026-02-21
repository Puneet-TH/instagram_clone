import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/pages/private_screen.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ChatProfile extends StatefulWidget {
  final snap;
  const ChatProfile({super.key, required this.snap});
  
  @override
  State<ChatProfile> createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  int unreadCount = 0;
  
  @override
  void initState() {
    super.initState();
    _calculateUnreadCount();
  }

  String _getConversationId(String uid1, String uid2) {
    List<String> ids = [uid1, uid2];
    ids.sort();
    return ids.join('_');
  }

  void _calculateUnreadCount() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final conversationId = _getConversationId(currentUserId, widget.snap['uid']);

    // Listen to messages in real-time
    FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .where('senderId', isEqualTo: widget.snap['uid'])
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((messagesSnapshot) {
      setState(() {
        unreadCount = messagesSnapshot.docs.length;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),
        child: Row(
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(widget.snap['photoUrl'] ?? ''),
              radius: 24
         ),
       Expanded(
           child: Padding(
         padding: EdgeInsets.only(left: 16),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   widget.snap['username'] ?? 'Unknown',
                   style: TextStyle(
                   fontWeight: FontWeight.bold,
                     fontSize: 18
                 ),
                 ),
               ],
             ),
           )
       ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateScreen(snapTarget: widget.snap, snapSource: user)));
              },
             child: Badge(
                 label: Text("$unreadCount"),
                 isLabelVisible: unreadCount > 0,
                 child: Icon(
                   Icons.messenger,
                   size: 24,
                 )
             ),
            )
            )
      ],
    ),
    );
  }
}
