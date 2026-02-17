import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatefulWidget {
  // final snap;
  const MessageCard({super.key});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://arstechnica.com/gaming/2016/04/dark-souls-3-review-marching-towards-masochism/'),
            radius: 18,
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
                            text: 'name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: 'hii freind',
                          ),
                        ]
                    )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        // DateFormat.yMMMd().format(
                        //   widget.snap['datePublished'].toDate(),
                        // ),
                        '12.00',
                        style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   child: Icon(
          //     Icons.favorite,
          //     size: 12,
          //   ),
          // )
        ],
      ),
    );
  }
}
