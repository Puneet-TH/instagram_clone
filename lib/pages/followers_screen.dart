import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/follow_following_card.dart';

class FollowersScreen extends StatefulWidget {
  final String uid;
  final String title; // "Followers" or "Following"
  final String type; // "followers" or "following"
  
  const FollowersScreen({
    super.key,
    required this.uid,
    this.title = "Followers",
    this.type = "followers",
  });

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<String> userIds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  void fetchFollowers() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        List fetchedIds = data[widget.type] ?? [];
        
        setState(() {
          userIds = fetchedIds.cast<String>();
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userIds.isEmpty
              ? Center(
                  child: Text(
                    'No ${widget.type}',
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: userIds.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userIds[index])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const SizedBox();
                        }

                        var userData = snapshot.data!.data() as Map<String, dynamic>;

                        return FollowFollowingCard(snap: userData);
                      },
                    );
                  },
                ),
    );
  }
}
