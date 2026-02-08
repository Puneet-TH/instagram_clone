import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/models/post.dart';
import 'package:instagramclone/resources/cloudinary_method.dart';
import 'package:instagramclone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //uploading the post
   Future<String> uploadPost(
       Uint8List file,
       String uid,
       String description,
       String username,
       String profImage
       ) async{
     String res = "some error occured";
      try{
        String photoUrl = await CloudinaryMethod().uploadPostImage(file);

        String postId = const Uuid().v1();
        Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          profImage: profImage,
          postUrl: photoUrl,
          likes: [],
        );
        
        _firestore
            .collection('posts')
            .doc(postId)
            .set(post.toJson());
        res = "success";
      }catch(err){
         res = err.toString();
      }
      return res;
   }
   
   Future<void> likePost(String postId, String uid, List likes)async{
     try{
       if(likes.contains(uid)){
         await _firestore.collection('posts').doc(postId).update(
           {
             'likes' : FieldValue.arrayRemove([uid]),
           }
         );
       }
       else{
         await _firestore.collection('posts').doc(postId).update(
             {
               'likes' : FieldValue.arrayUnion([uid]),
             }
         );
       }
     }
     catch(err){
       print(err.toString());
     }
   }

   Future<void> postComment(String postId, String text, String uid, String name, String profilePic) async {

     try{
       if(text.isNotEmpty){
         String commentId = const Uuid().v1();
         await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(
           {
             'profilePic' : profilePic,
             'name' : name,
             'uid' : uid,
             'text' : text,
             'commentId' : commentId,
             'datePublished' : DateTime.now(),
           }
         );
       }
       else{
         print('Text is empty');
       }
     }
     catch(e){
       print(e.toString());
     }
   }

   Future<void> deletePost(String postId) async {
     try{
      await _firestore.collection('posts').doc(postId).delete();
     }
     catch(err){
       print(err.toString());
     }
   }
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeComment(String postId, String commentId, String uid, List likes) async{
     try{
       if(likes.contains(uid)){
         await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update(
             {
               'likes' : FieldValue.arrayRemove([uid]),
             }
         );
       }
       else{
         await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update(
             {
               'likes' : FieldValue.arrayUnion([uid]),
             }
         );
       }
     }
     catch(err){
       print("some error occured while liking comment");
     }
  }

}