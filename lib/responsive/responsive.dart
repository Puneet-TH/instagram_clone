import 'package:flutter/material.dart';
import 'package:instagramclone/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget{

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key,
     required this.webScreenLayout,
     required this.mobileScreenLayout,}) : super(key: key);
  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState(){
    super.initState();
    addData();
  }

  void addData() async{

  }
  @override
  Widget build(BuildContext context) {
      return LayoutBuilder(builder: (context, constraints) {
         if(constraints.maxWidth > webScreenSize){
            return webScreenLayout;
         }
         return mobileScreenLayout;
         //mobile screen layout
      });
    }
}