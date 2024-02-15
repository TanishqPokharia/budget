import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class NewExpense extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense>{
  List<String> categories = [
    "food",
    "leisure",
    "maintenance",
    "medicine",
    "recharge",
    "rent",
    "shopping",
    "stationary",
    "travel",
    "miscellaneous",
  ];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories[0];
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text("Title"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: Text("Description"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
            ),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
              label: Text("Amount"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Responsive.size(context, 10)))
              ),
            ),
          ),
          Row(children: [ElevatedButton(onPressed: (){}, child: Text("Pick Date"))],),
           DropdownMenu(
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "food", label: "food",leadingIcon: Icon(Icons.lunch_dining)),
              DropdownMenuEntry(value: "leisure", label: "leisure",leadingIcon: Icon(Icons.movie)),
              DropdownMenuEntry(value: "maintenance", label: "maintenance",leadingIcon: Icon(Icons.handyman)),
              DropdownMenuEntry(value: "medicine", label: "medicine",leadingIcon: Icon(Icons.medical_information)),
              DropdownMenuEntry(value: "recharge", label: "recharge",leadingIcon: Icon(Icons.credit_card)),
              DropdownMenuEntry(value: "rent", label: "rent",leadingIcon: Icon(Icons.house_rounded)),
              DropdownMenuEntry(value: "shopping", label: "shopping",leadingIcon: Icon(Icons.shopping_cart)),
              DropdownMenuEntry(value: "stationary", label: "stationary",leadingIcon: Icon(Icons.create)),
              DropdownMenuEntry(value: "travel", label: "travel",leadingIcon: Icon(Icons.train)),
              DropdownMenuEntry(value: "miscellaneous", label: "miscellaneous",leadingIcon:Icon(Icons.help)),
            ],
            onSelected: (value){
              setState(() {
                selectedCategory = value!;
              });
            }
          ),
        ],
      ),

    );
  }
}