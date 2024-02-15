import 'package:budget_buddy_2/router/app_router.dart';
import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  //Google user information
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  //Method called when user presses on SignIn with Google

  Future googleLogin(context) async {
    //Google SignIn Popup Dialog
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
                width: 200,
                height: 150,
                child: Center(
                  child: Text(
                    "User Invalid",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        );
        return;
      }

      //save the user
      _user = googleUser;

      //Get access token and id token after authentication
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      //Sign in the user with their google credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      final currentUser = FirebaseAuth.instance.currentUser;

      // Check if the user already has a Firestore document
      // final userDocument = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(currentUser!.uid)
      //     .get();
      //
      //

      //Finally , update UI

      notifyListeners();

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Signed In Successfully!")));

      // GoRouter.of(context).goNamed(AppRouterConstants.navigationScreen);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: SizedBox(
                    height: 200,
                    width: 150,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Check internet connection and try again",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )),
              ));
    }
  }

  Future googleLogout(context) async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("LoggedOut")));
    GoRouter.of(context).goNamed(AppRouterConstants.signInScreen);
  }
}
