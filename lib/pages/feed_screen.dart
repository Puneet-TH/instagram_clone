import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/pages/chat_screen.dart';
import 'package:instagramclone/providers/user_provider.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          //SvgPicture.asset
          title: InkWell(
            //can add ontap as well to push  home
              child: Image.asset('assets/images/instagram_logo.png', scale: 3.5,)),
          actions: [
            StreamBuilder<QuerySnapshot>(
              stream: user?.uid != null 
                ? FirebaseFirestore.instance
                    .collectionGroup('messages')
                    .where('receiverId', isEqualTo: user!.uid)
                    .where('isRead', isEqualTo: false)
                    .snapshots()
                : null,
              builder: (context, snapshot) {
                int totalUnread = 0;
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen(snap: user))
                    ),
                    icon: const Icon(Icons.messenger_outline),
                  );
                }
                
                if (snapshot.hasError) {
                  print('Feed screen badge error: ${snapshot.error}');
                }
                
                if (snapshot.hasData) {
                  totalUnread = snapshot.data!.docs.length;
                  print('Total unread messages: $totalUnread');
                }

                return IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(snap: user))
                  ),
                  icon: Badge(
                    label: Text('$totalUnread'),
                    isLabelVisible: totalUnread > 0,
                    child: const Icon(Icons.messenger_outline),
                  ),
                );
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Server under maintainence',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:
                    (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                )
            );
          },
        )
    );
  }

}
