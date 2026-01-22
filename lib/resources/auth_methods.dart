import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/resources/cloudinary_method.dart';

import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }



  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
}) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

         String photoUrl = await CloudinaryMethod().uploadProfilePicture(file);

         model.User user = model.User(
             email: email,
             password: password,
             username: username,
             bio: bio,
             followers: [],
             following: [],
             uid: cred.user!.uid,
             photoUrl: photoUrl,
         );

        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = "success";
      }
    }
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = "the email is badly formatted";
    //   } else if(err.code == 'weak-password'){
    //     res = "password should be at least 6 characters";
    //   }
    // }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
}) async{
    String res = "Some error occured";

    try{
      if(email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = "success";
      }
      else{
        res = "Please enter all the fields";
      }
    }
    catch(err){
        res = err.toString();
    }
    return res;
  }


}