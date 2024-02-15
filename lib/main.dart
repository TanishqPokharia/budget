// import 'package:budget_buddy_2/models/expense/expense.dart';
// import 'package:budget_buddy_2/screens/expense_screen/expense_page.dart';
import 'package:budget_buddy_2/auth/google_sign_in.dart';
import 'package:budget_buddy_2/firebase_options.dart';
import 'package:budget_buddy_2/models/expense/expense.dart';
import 'package:budget_buddy_2/router/app_router.dart';
import 'package:budget_buddy_2/screens/InsightPage/insight_page..dart';
import 'package:budget_buddy_2/screens/ai_mentor/ai_mentor.dart';
import 'package:budget_buddy_2/screens/expense_screen/expense_page.dart';
import 'package:budget_buddy_2/screens/finance_buddy/finance_buddy.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as Provider;

bool firstOpen = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}
// ChatUser chatUser = ChatUser(id: "1",firstName: "Tanishq",lastName: "Pokharia");
// ChatUser aiMentor = ChatUser(id: "2",firstName: "Mentor");



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
      ),
      // child: MaterialApp(
      //   home:,
      // ),
    );
  }
}
