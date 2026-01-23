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
}