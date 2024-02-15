import 'package:budget_buddy_2/screens/InsightPage/insight_page..dart';
import 'package:budget_buddy_2/screens/expense_screen/expense_page.dart';
import 'package:budget_buddy_2/screens/finance_buddy/finance_buddy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final indexProvider = StateProvider<int>((ref) => 0);
List<Widget> screens = [
  // ExpensePage(expenseList: expenseList, winLossDataList: winLossDataList),
  FinanceBuddy(),
  InsightPage(),
];

class NavigationPage extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart_rounded),label: "Expense"),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer_rounded),label: "Buddy"),
          BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf),label: "Insight"),
        ],
        onTap: (value) {
          ref.read(indexProvider.notifier).state = value;
        },
        currentIndex: ref.watch(indexProvider),
      ),
      body: screens[ref.read(indexProvider)],
    );
  }
}
