import 'package:budget_buddy_2/auth/auth_services.dart';
import 'package:budget_buddy_2/auth/google_sign_in.dart';
import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKeySignIn = GlobalKey<FormState>();
  bool _passwordHideStatus = true;
  String email = "";
  String password = "";
  bool waiting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black12,
        body: Stack(
          children: [
            Form(
              key: _formKeySignIn,
              child: Container(
                padding: EdgeInsets.all(Responsive.size(context, 15)),
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
                          style: TextStyle(fontSize: Responsive.size(context, 21),color: Colors.white),
                          key: const ValueKey("emailSignIn"),
                          validator: (value) {
                            if (value!.length < 5) {
                              return "Not a valid email";
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
                                "Email",
                                style: TextStyle(fontSize: Responsive.size(context, 25),color: Colors.white),
                                // style: TextStyle(fontSize: 20),
                              )),
                        )),
                    SizedBox(
                      height: Responsive.size(context, 55),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Responsive.size(context, 45)),
                      child: TextFormField(
                        style: TextStyle(fontSize: Responsive.size(context, 21),color: Colors.white),
                        key: const ValueKey("passwordSignIn"),
                        validator: (value) {
                          if (value!.length < 5) {
                            return "Create a strong password";
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
                              style: TextStyle(fontSize: Responsive.size(context, 25),color: Colors.white),
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: Responsive.size(context, 35), right: Responsive.size(context, 45)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Response");
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontSize: Responsive.size(context, 21),
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Responsive.size(context, 45)),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: Responsive.size(context, 65)),
                            height: Responsive.size(context, 65),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKeySignIn.currentState!.validate()) {
                                    _formKeySignIn.currentState!.save();
                                    AuthServices.signInUser(
                                        email, password, context);
                                  }
                                },
                                child: Text("Sign In",
                                    style:
                                    TextStyle(fontSize: Responsive.size(context, 21)))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Responsive.size(context, 35)),
                            height: Responsive.size(context, 65),
                            width: double.infinity,
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Responsive.size(context, 35)),
                                            side: BorderSide(
                                                width: Responsive.size(context, 2),
                                                color: Colors.teal)))),
                                onPressed: () {
                                  final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                                  // waitForLogin(provider.googleLogin(context));
                                  setState(() {
                                    waiting = true;
                                  });
                                  provider
                                      .googleLogin(context)
                                      .whenComplete(() {
                                    setState(() {
                                      waiting = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Signed In Successfully!")));

                                    GoRouter.of(context).goNamed(
                                        AppRouterConstants.expenseScreen);
                                  });
                                },
                                child: Row(
                                  // spacing: mq(context, 15),
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      size: Responsive.size(context, 24),
                                    ),
                                    SizedBox(
                                      width: Responsive.size(context, 15),
                                    ),
                                    Text(
                                      "Sign in with Google",
                                      style: TextStyle(
                                          fontSize: Responsive.size(context, 21),
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(Responsive.size(context, 40)),
                      child: Wrap(
                        spacing: Responsive.size(context, 10),
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: Responsive.size(context, 21),color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                GoRouter.of(context)
                                    .goNamed(AppRouterConstants.signUpScreen);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.size(context, 21),color: Colors.deepPurple),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            waiting
                ? const Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ));
  }
}
