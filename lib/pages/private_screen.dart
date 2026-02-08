
import 'package:flutter/material.dart';

class PrivateScreen extends StatefulWidget {
  const PrivateScreen({super.key});

  @override
  State<PrivateScreen> createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Active Now ',
          style: TextStyle(color: Colors.lightGreenAccent),
        ),
        centerTitle: true,
      ),
    );
  }
}
