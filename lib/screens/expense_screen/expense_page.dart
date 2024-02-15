import 'dart:convert';

import 'package:budget_buddy_2/auth/google_sign_in.dart';
import 'package:budget_buddy_2/main.dart';
import 'package:budget_buddy_2/models/expense/expense.dart';
import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:budget_buddy_2/widgets/expense_item.dart/expense_item.dart';
import 'package:budget_buddy_2/widgets/new_expense_modal..dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:provider/provider.dart' as PR;
import 'package:http/http.dart' as http;


class ExpensePage extends ConsumerStatefulWidget{
  const ExpensePage(
      {super.key, required this.expenseList, required this.winLossDataList});
  final List<num> winLossDataList;
  final List<Expense> expenseList;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return ExpensePageState();
  }
}
class ExpensePageState extends ConsumerState<ExpensePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(firstOpen){
      getBuddyComment();
    }
    firstOpen = false;


  }

  openNewExpenseModal(){
    showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      context: context,
      builder: (context)=>NewExpense(),
      enableDrag: false,
    );
  }



  getBuddyComment() async{
    final geminiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCMUQyaW4Ho7BNK63kGQR3SJucwgGd_GHA";
    final header = {
      "Content-Type": 'applications/json'
    };
    var data = {
      "contents": [{"parts": [{"text": "analyze my financial data, including income: Rs. ${1200000} per year, expenses: Rs. ${10000}, and savings: Rs ${2000}. Provide insights into spending patterns, identify potential areas for savings, and offer personalized financial health assessments. Give in bullet points and  strictly less than 100 words, do not use markdown text to give response"}]}]
    };

    await http.post(Uri.parse(geminiUrl), headers: header, body: jsonEncode(data)).then((value){
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        showDialog(context: context, builder: (context) => Dialog(
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(Responsive.size(context, 30)),
                padding: EdgeInsets.all(Responsive.size(context, 10)),
                child: Column(
                  children: [
                    Wrap(children: [
                      Text(result['candidates'][0]['content']['parts'][0]['text'])
                    ],),
                    SizedBox(
                      height: Responsive.size(context, 30),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("OK"))
                  ],
                )
          )
          ),
        ));
      }}).catchError((error){
      print(error);
    }
    );

  }

  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
        actions: [
          TextButton(onPressed: (){
            final provider = PR.Provider.of<GoogleSignInProvider>(context,listen: false);
            provider.googleLogout(context);
          }, child: Text("Logout")),
          IconButton(onPressed: (){
            GoRouter.of(context).goNamed(AppRouterConstants.buddyScreen);
          }, icon: const Icon(Icons.question_answer_rounded))
        ],
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              openNewExpenseModal();
            },
            label: Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: [
                Icon(Icons.add),
                Text(
                  "Add Expense",
                  style: TextStyle(fontSize: Responsive.size(context, 20)),
                )
              ],
            )),
        backgroundColor: Color.fromARGB(255, 12, 12, 26),
        body: Container(
          margin: EdgeInsets.zero,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(Responsive.size(context, 20)),
                    height: 500,
                    margin: EdgeInsets.all(Responsive.size(context, 20)),
                    width: MediaQuery.sizeOf(context).width,
                    // width: 200,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Responsive.size(context, 20)),
                        color: Color.fromARGB(255, 41, 31, 71)),
                    child: SfCircularChart(
                      title: ChartTitle(
                          text: "Expense Distribution",
                          textStyle: TextStyle(color: Colors.white),
                          alignment: ChartAlignment.center),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      legend: Legend(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.size(context, 16)),
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: [
                        DoughnutSeries<Expense, String>(
                          radius: "80%",
                          pointColorMapper: (datum, index) => datum.color,
                          xValueMapper: (datum, index) => datum.category,
                          yValueMapper: (datum, index) => datum.amount,
                          dataSource: expenseList,
                          // dataLabelSettings: DataLabelSettings(
                          //     isVisible: true,
                          //     textStyle: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: Responsive.size(context, 18),
                          //         fontWeight: FontWeight.bold)),
                          enableTooltip: true,
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(Responsive.size(context, 20)),
                  height: Responsive.size(context, 250),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Responsive.size(context, 20)),
                        width: Responsive.size(context, 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Responsive.size(context, 20)),
                            color: Color.fromARGB(255, 41, 31, 71)),
                        child: Column(
                          children: [
                            Container(

                                margin: EdgeInsets.only(
                                    bottom: Responsive.size(context, 20)),
                                child: Text(
                                  "Targets Met",
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                )),
                            SfSparkWinLossChart(
                              data: widget.winLossDataList,
                              trackball: SparkChartTrackball(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        padding: EdgeInsets.all(Responsive.size(context, 20)),
                        width: Responsive.size(context, 200),
                        height: Responsive.size(context, 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Responsive.size(context, 20)),
                            color: Color.fromARGB(255, 41, 31, 71)),
                        child: CircularPercentIndicator(
                          radius: Responsive.size(context, 70),
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 13,
                          percent: 0.4,
                          center: new Text(
                            "40/100",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ),
                          header: Container(
                              margin: EdgeInsets.only(
                                  bottom: Responsive.size(context, 20)),
                              child: Text(
                                "Daily Budget",
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              )),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.cyan,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(
                    Responsive.size(context, 20),
                  ),
                  child: Column(
                      children: expenseList
                          .map((e) => ExpenseItem(expense: e))
                          .toList()),
                )
              ],
            ),
          ),
        ));
  }
}
