import 'package:flutter/material.dart';

class Expense {
  final String title;
  final String description;
  final double amount;
  final String category;
  final String date;
  final String month;
  Color get color {
    switch (category) {
      case "food":
        return Colors.orange;
      case "leisure":
        return Colors.pink;
      case "maintainence":
        return Colors.blue;
      case "medicine":
        return Colors.deepOrange;
      case "recharge":
        return Colors.cyan;
      case "rent":
        return Colors.lightGreen;
      case "shopping":
        return Colors.purple;
      case "stationary":
        return Colors.yellow;
      case "travel":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Expense(
      {required this.title,
      required this.description,
      required this.amount,
      required this.category,
      required this.date,
      required this.month,
      });
}

List<Expense> expenseList = [
  // Food expense
  Expense(
    title: "Grocery shopping",
    description: "Fruits, vegetables, and pantry staples",
    amount: 50.00,
    category: "food",
    date: "10/02/2024",
    month: "February,2024",
  ),
  // Leisure expense
  Expense(
    title: "Movie tickets",
    description: "Two tickets for a new rom-com",
    amount: 30.00,
    category: "leisure",
    date: "15/02/2024",
    month: "February,2024",
  ),
  // Maintenance expense
  Expense(
    title: "Car wash",
    description: "Full wash and interior cleaning",
    amount: 25.00,
    category: "maintainence",
    date: "02/02/2024",
    month: "February,2024",
  ),
  // Medicine expense
  Expense(
    title: "Prescription refill",
    description: "Monthly medication",
    amount: 40.00,
    category: "medicine",
    date: "08/02/2024",
    month: "February,2024",
  ),
  // Recharge expense
  Expense(
    title: "Phone top-up",
    description: "Mobile data recharge",
    amount: 15.00,
    category: "recharge",
    date: "13/02/2024",
    month: "February,2024",
  ),
  // Rent expense
  Expense(
    title: "Monthly rent payment",
    description: "Apartment rent for February",
    amount: 800.00,
    category: "rent",
    date: "01/02/2024",
    month: "February,2024",
  ),
  // Shopping expense
  Expense(
    title: "New book",
    description: "Novel by a favorite author",
    amount: 20.00,
    category: "shopping",
    date: "05/02/2024",
    month: "February,2024",
  ),
  // Stationary expense
  Expense(
    title: "Office supplies",
    description: "Pens, notebooks, and sticky notes",
    amount: 10.00,
    category: "stationary",
    date: "07/02/2024",
    month: "February,2024",
  ),
  // Travel expense
  Expense(
    title: "Taxi ride",
    description: "Airport transportation",
    amount: 35.00,
    category: "travel",
    date: "12/02/2024",
    month: "February,2024",
  ),
  // Other expense
  Expense(
    title: "Coffee shop visit",
    description: "Latte and a pastry",
    amount: 5.00,
    category: "other",
    date: "14/02/2024",
    month: "February,2024",
  ),
];
