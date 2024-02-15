import 'package:budget_buddy_2/auth/auth_services.dart';
import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }
}
class SignUpScreenState extends State<SignUpScreen>{
  @override
  final _formKeySignUp = GlobalKey<FormState>();
  bool _passwordHideStatus = true;
  String fullName = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black12,
        body: Form(
          key: _formKeySignUp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                  child: Image.asset(
                    "assets/applogo.png",
                    width: Responsive.size(context, 350),
                    height: Responsive.size(context, 250),
                  ),

              ),
              Container(
                  margin: EdgeInsets.only(
                      top: Responsive.size(context, 55),
                      right: Responsive.size(context, 45),
                      left: Responsive.size(context, 45)),
                  child: TextFormField(
                    style: TextStyle(fontSize: Responsive.size(context, 21)),
                    key: const ValueKey("emailSignUp"),
                    validator: (value) {
                      if (value!.length < 5 ||
                          value.isEmpty ||
                          !value.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      setState(() {
                        email = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Responsive.size(context, 25)))),
                        label: Text(
                          "Email", style: TextStyle(fontSize: Responsive.size(context, 25)),
                          // style: TextStyle(fontSize: 20),
                        )),
                  )),
              SizedBox(
                height: Responsive.size(context, 55),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Responsive.size(context, 45)),
                child: TextFormField(
                  style: TextStyle(fontSize: Responsive.size(context, 21)),
                  key: const ValueKey("fullname"),
                  validator: (value) {
                    if (!value!.contains(" ")) {
                      return "Please enter your full name";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    setState(() {
                      fullName = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(Responsive.size(context, 25)))),
                    label: Text(
                      "Full Name",
                      style: TextStyle(fontSize: Responsive.size(context, 25)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.size(context, 55),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Responsive.size(context, 45)),
                child: TextFormField(
                  style: TextStyle(fontSize: Responsive.size(context, 21)),
                  key: const ValueKey("passwordSignUp"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return "Please create a strong password";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    setState(() {
                      password = newValue!;
                    });
                  },
                  obscureText: _passwordHideStatus,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Responsive.size(context, 25)))),
                      label: Text(
                        "Password",
                        style: TextStyle(fontSize: Responsive.size(context, 25)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordHideStatus
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordHideStatus = !_passwordHideStatus;
                          });
                        },
                      )),
                ),
              ),
              Container(padding: EdgeInsets.only(top: Responsive.size(context, 45))),
              Container(
                margin: EdgeInsets.only(top: Responsive.size(context, 65)),
                padding: EdgeInsets.symmetric(horizontal: Responsive.size(context, 45)),
                height: Responsive.size(context, 65),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKeySignUp.currentState!.validate()) {
                        _formKeySignUp.currentState!.save();
                        AuthServices.signUpUser(
                            email, fullName, password, context);
                        GoRouter.of(context).goNamed(AppRouterConstants.expenseScreen);
                      }
                    },
                    child: Text("Sign Up",
                        style: TextStyle(fontSize: Responsive.size(context, 21)))),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Responsive.size(context, 35),
                    right: Responsive.size(context, 45),
                    left: Responsive.size(context, 45)),
                child: Wrap(
                  spacing: Responsive.size(context, 10),
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: Responsive.size(context, 21)),
                    ),
                    GestureDetector(
                        onTap: () {
                          GoRouter.of(context)
                              .goNamed(AppRouterConstants.signInScreen);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.size(context, 21)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}