import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';
class ServiceDown extends StatelessWidget {
  const ServiceDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Service is temperorily down',
        style: TextStyle(color: primaryColor, fontSize: 20
        ),),
    );
  }
}
