import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/post_card.dart';

class FeedScreen  extends StatelessWidget{
  const FeedScreen({Key? key}) : super(key : key);
  
  @override
  Widget build(BuildContext context){
       return Scaffold(
         appBar: AppBar(
           backgroundColor: mobileBackgroundColor,
           centerTitle: false,
           //SvgPicture.asset
           title: Text('INSTAGRAM'),
           actions: [
             IconButton(onPressed: (){},
                 icon: const
                 Icon(
                   Icons.messenger_outline,),),
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

