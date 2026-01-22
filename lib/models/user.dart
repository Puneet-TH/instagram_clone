import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String password;
  final String username;
  final String bio;
  final String uid;
  final String photoUrl;
  final List followers;
  final List following;

  const User(
  {
    required this.email,
    required this.password,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.uid,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "photoUrl" : photoUrl,
    "password" : password,
    "email" : email,
    "bio" : bio,
    "followers" : followers,
    "following" : following,
  };

  static User fromSnap(DocumentSnapshot snap){
     var snapshot = snap.data() as Map<String, dynamic>;

     return User(
       username: snapshot['username'],
       uid: snapshot['uid'],
       photoUrl: snapshot['photoUrl'],
       password: snapshot['password'],
       email: snapshot['email'],
       bio: snapshot['bio'],
       followers: snapshot['followers'],
       following: snapshot['following'],
     );
  }

}