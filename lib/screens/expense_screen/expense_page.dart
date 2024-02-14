import 'package:budget_buddy_2/models/expense/expense.dart';
import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:budget_buddy_2/widgets/expense_item.dart/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ExpensePage extends ConsumerWidget {
  const ExpensePage(
      {super.key, required this.expenseList, required this.winLossDataList});
  final List<num> winLossDataList;
  final List<Expense> expenseList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
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
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.size(context, 18),
                                  fontWeight: FontWeight.bold)),
                          enableTooltip: true,
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(Responsive.size(context, 20)),
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Responsive.size(context, 20)),
                        width: 180,
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
                                  style: TextStyle(fontSize: 18),
                                )),
                            SfSparkWinLossChart(
                              data: winLossDataList,
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
                        width: 180,
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
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          header: Container(
                              margin: EdgeInsets.only(
                                  bottom: Responsive.size(context, 20)),
                              child: Text(
                                "Daily Budget",
                                style: TextStyle(fontSize: 18),
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
