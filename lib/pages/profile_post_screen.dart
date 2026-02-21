import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:instagramclone/pages/feed_screen.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/post_card.dart';
class ProfilePostScreen extends StatefulWidget {
  final uid;
  const ProfilePostScreen({super.key, required this.uid});
  @override
  State<ProfilePostScreen> createState() => _ProfilePostScreenState();
}

class _ProfilePostScreenState extends State<ProfilePostScreen> {
  int postLen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        //SvgPicture.asset
        title: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout())),
          child: Container(child: Image.asset('assets/images/instagram_logo.png', scale: 3.5,),),
        )
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).snapshots() ,
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
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
       return  ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:
                    (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                )
            );
          }),
    );
  }
}

