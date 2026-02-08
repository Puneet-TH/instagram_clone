import 'package:flutter/material.dart';
import 'package:instagramclone/pages/private_screen.dart';

class ChatProfile extends StatefulWidget {
  final snap;
  const ChatProfile({super.key, required this.snap});
  
  @override
  State<ChatProfile> createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  // int num = 0;
  // void newMessage(){
  //   //check in db for new message
  //   setState(() {
  //      num += 1;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateScreen()));
              },
             child: Badge(
                 label: Text("1"),
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
