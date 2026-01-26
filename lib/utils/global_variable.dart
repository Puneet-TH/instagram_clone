import 'package:flutter/material.dart';
import 'package:instagramclone/pages/add_post_screen.dart';
import 'package:instagramclone/pages/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];
