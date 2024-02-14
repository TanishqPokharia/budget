// import 'package:budget_buddy_2/models/expense/expense.dart';
// import 'package:budget_buddy_2/screens/expense_screen/expense_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        body: Center(
          child: Text("Hello"),
        ),
      ),
      // home: ExpensePage(expenseList: expenseList, winLossDataList: [
      //   1,
      //   2,
      //   3,
      //   -1,
      //   2,
      //   -5,
      //   -1,
      //   1,
      //   2,
      //   3,
      //   2,
      //   -1,
      //   2,
      //   2,
      //   3,
      //   -1,
      //   2
      // ]),
    );
  }
}
