import 'package:budget_buddy_2/models/expense/expense.dart';
import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});
  IconData get icon {
    switch (expense.category) {
      case "food":
        return Icons.lunch_dining_rounded;
      case "leisure":
        return Icons.movie_rounded;
      case "maintainence":
        return Icons.handyman_rounded;
      case "medicine":
        return Icons.medical_information_rounded;
      case "recharge":
        return Icons.credit_card_rounded;
      case "rent":
        return Icons.house_rounded;
      case "shopping":
        return Icons.shopping_cart_rounded;
      case "stationary":
        return Icons.create_rounded;
      case "travel":
        return Icons.train_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(Responsive.size(context, 10)),
      width: double.infinity,
      child: Card(
        color: Color.fromARGB(255, 41, 31, 71),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(Responsive.size(context, 15)),
              child: Wrap(
                spacing: 5,
                children: [
                  Icon(icon, color: expense.color),
                  Text(
                    expense.title,
                    style: TextStyle(fontSize: Responsive.size(context, 18)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(Responsive.size(context, 18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount: ${expense.amount.toString()}",
                    style: TextStyle(
                        fontSize: Responsive.size(context, 16),
                        color: expense.color),
                  ),
                  Text(
                    "Date: ${expense.date}",
                    style: TextStyle(
                        fontSize: Responsive.size(context, 16),
                        color: expense.color),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
