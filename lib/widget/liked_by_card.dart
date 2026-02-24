import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/pages/profile_screen.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:intl/intl.dart';

class LikedByCard extends StatefulWidget {
  final userId;
  final postId;
  const LikedByCard({super.key, required this.userId, required this.postId});

  @override
  State<LikedByCard> createState() => _LikedByCardState();
}

class _LikedByCardState extends State<LikedByCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder( //future builder tab use kare jab query lga ke snap mile
      future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            child: const Text('User not found'),
          );
        }

        var snap = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: widget.userId))),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(snap['photoUrl']),
                    radius: 18,
                  ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                text: snap['username']?? 'unknown',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: widget.userId)))
                              ),
                              const TextSpan(
                                text: ' liked your post',
                                style: TextStyle(color: primaryColor),
                              ),
                            ]
                        )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            DateFormat.yMMMd().format(DateTime.now()),
                            style: const TextStyle(fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              widget.postId != null ? Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.postId),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
