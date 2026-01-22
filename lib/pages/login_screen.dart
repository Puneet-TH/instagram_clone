import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/pages/singup_screen.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/utils/utils.dart';
import 'package:instagramclone/widget/text_field.dart';

class LoginScreen  extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
 void loginUser() async{
    setState(() {
       _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text);
    if(res == "success"){

    }
    else{
      ShowSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
 }

 void navigateToSignup(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignupScreen())
    );
 }

  @override
  Widget build(BuildContext context) {
    //pixel reflux error was because safe area is not a material widget
    //and we can call only material widget inside material widget

   return Scaffold(body: SafeArea(
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
           Text('INSTAGRAM' , style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 32,
           ), ),
           const SizedBox(height: 64),
           TextFieldInput(
               textInputType: TextInputType.emailAddress,
               textEditingController: _emailController,
               hintText: 'Enter your Email'
           ),
           const SizedBox(height: 24),
           TextFieldInput(
               textInputType: TextInputType.text,
               textEditingController: _passwordController,
               hintText: 'Enter your Password',
               isPass: true,
           ),
           const SizedBox(
             height: 24,
           ),

           InkWell(
             onTap: loginUser,
             child :Container(
             child: _isLoading ? const Center(child: CircularProgressIndicator(
               color: primaryColor,
             ),) : const Text('Log In'),
             width: double.infinity,
             alignment: Alignment.center,
             padding: const EdgeInsets.symmetric(vertical: 12),
             decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(
                 Radius.circular(4),
               )
              ),
               color: blueColor
             ),
           ),
           ),
           SizedBox(
             height: 12,
           ),
           Flexible(flex: 2,child: Container()),
           
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 child: Text("Don't have an account ?"),
                 padding: const EdgeInsets.symmetric(
                   vertical: 8,
                 ),
               ),
               GestureDetector(
                 onTap: navigateToSignup,
                 child: Container(
                 child: Text("Sign up.",
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 padding: const EdgeInsets.symmetric(
                   vertical: 8,
                 ),
                ),
               ),
             ],
           )
         ],
       ),
     ),
   ),
   );
  }

}