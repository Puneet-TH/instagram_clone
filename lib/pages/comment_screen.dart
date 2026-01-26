import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/comment_card.dart';


class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXBxkhNFRNy7c0KbPlET_csQZciZ68ntDTBg&s',
                ),
                radius: 18 ,
              ),
             Expanded(
                 child: Padding(
                   padding: const EdgeInsets.only(left: 16, right: 8),
                   child:  TextField(
                     decoration: InputDecoration(
                       hintText: 'Comment  as username',
                       border: InputBorder.none,
                     ),
                   ),
                 )
             ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text('Post', style: TextStyle(
                    color: Colors.blueAccent,
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
