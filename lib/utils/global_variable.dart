import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/pages/add_post_screen.dart';
import 'package:instagramclone/pages/feed_screen.dart';
import 'package:instagramclone/pages/profile_screen.dart';
import 'package:instagramclone/pages/search_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen() ,
  AddPostScreen(),
  Text('notif'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
