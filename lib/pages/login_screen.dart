import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widget/text_field.dart';

class LoginScreen  extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Container(
       padding: const EdgeInsets.symmetric(horizontal: 32),
       width: double.infinity,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Flexible(flex: 2,child: Container()),
           // SvgPicture.asset(
           //   'assets/ic_instagram.svg',
           //   color: primaryColor,
           //   height: 64,
           // ),
           //
           const SizedBox(height: 64),
           TextFieldInput(
               textInputType: TextInputType.emailAddress,
               textEditingController: _emailController,
               hintText: 'Enter your Email'
           ),
         ],
       ),
     ),
   );
  }

}