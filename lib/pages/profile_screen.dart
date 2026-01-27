import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           backgroundColor: mobileBackgroundColor,
           title: const Text('Profile'),
           centerTitle: false,
         ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4AAbbL2Ds8bmv3PY2Nd5_KvookLE8Vsqkkw&s'
                        ),
                        radius: 40,
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(1, "posts"),
                          buildStatColumn(400, "followers"),
                          buildStatColumn(500, "following"),
                        ],
                      ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                               //followbutton widget call
                              // FollowButton(
                              //   backgroundColor: mobileBackgroundColor,
                              //   borderColor: Colors.grey,
                              //   text: 'Edit Profile',
                              //   textColor: primaryColor,
                              //   function: (){},
                              // )
                          ]
                      )
                    ],
                  )
                ],
              ),
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Container(
           margin: const EdgeInsetsGeometry.only(top: 4),
           child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey
                  ),
                ),
        ),
      ]
    );
  }
}
