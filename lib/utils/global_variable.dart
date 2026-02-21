import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/pages/add_post_screen.dart';
import 'package:instagramclone/pages/feed_screen.dart';
import 'package:instagramclone/pages/liked_by_screen.dart';
import 'package:instagramclone/pages/profile_post_screen.dart';
import 'package:instagramclone/pages/profile_screen.dart';
import 'package:instagramclone/pages/search_screen.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen() ,
  AddPostScreen(),
  LikedByScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
