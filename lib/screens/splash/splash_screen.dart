import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:budget_buddy_2/screens/user_authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      user==null?GoRouter.of(context).goNamed(AppRouterConstants.signInScreen):GoRouter.of(context).goNamed(AppRouterConstants.expenseScreen);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Image.asset("assets/applogo.png"),
      ),
    );
  }
}
