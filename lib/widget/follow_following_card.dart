import 'package:flutter/material.dart';
import 'package:instagramclone/pages/profile_screen.dart';
import 'package:instagramclone/pages/service_down.dart';
import 'package:instagramclone/utils/colors.dart';

class FollowFollowingCard extends StatefulWidget {
  final snap;
  const FollowFollowingCard({super.key, required this.snap});
  @override
  State<FollowFollowingCard> createState() => _FollowFollowingCardState();
}

class _FollowFollowingCardState extends State<FollowFollowingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),
        child: Row(
          children: [
            InkWell(
              onTap: (){
                 if(widget.snap['uid'] == null){
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder:
                               (context) => ServiceDown()
                       )
                   );
                 }
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ProfileScreen(uid: widget.snap['uid'])
                 ));
              },
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.snap['photoUrl'] ??
                    'https://media.gq-magazine.co.uk/photos/5d138da5d7a7010d5bbb99a4/16:9/w_2560%2Cc_limit/dark_souls_remastered_crop.jpg'
                  ),
                  radius: 24,
                ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          if(widget.snap['uid'] == null){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                        (context) => ServiceDown()
                                )
                            );
                          }
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfileScreen(uid: widget.snap['uid'])
                          ));
                        },
                        child: Text(
                            widget.snap['username'] ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.snap['bio'] ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
              //add follow button here if needed
            )
          ],
        ),
    );
  }
}
