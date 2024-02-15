import 'dart:convert';

import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class FinanceBuddy extends StatefulWidget {
  const FinanceBuddy({Key? key}) : super(key: key);

  @override
  State<FinanceBuddy> createState() => _FinanceBuddyState();
}

class _FinanceBuddyState extends State<FinanceBuddy> {
  final geminiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCMUQyaW4Ho7BNK63kGQR3SJucwgGd_GHA";
  final header = {
    "Content-Type": 'applications/json'
  };
  ChatUser user = ChatUser(id: "1",firstName: "Tanishq");
  ChatUser aiMentor = ChatUser(id: "2",firstName: "Buddy");
  List<ChatMessage> messageList = [];
  List<ChatUser> typing = [];
  getData(ChatMessage message) async {
    typing.add(aiMentor);
    messageList.insert(0, message);
    var data = {
      "contents": [{"parts": [{"text": message.text}]}]
    };


      await http.post(Uri.parse(geminiUrl), headers: header, body: jsonEncode(data)).then((value){
        if (value.statusCode == 200) {
          var result = jsonDecode(value.body);
          ChatMessage chatMessage = ChatMessage(
            user: aiMentor,
            createdAt: DateTime.now(),
            text: result['candidates'][0]['content']['parts'][0]['text'],
          );
          messageList.insert(0, chatMessage);
      }}).catchError((error){
        print(error);
        }
        );
      typing.remove(aiMentor);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buddy"),
      actions: [
        IconButton(onPressed: (){
          GoRouter.of(context).goNamed(AppRouterConstants.expenseScreen);
        }, icon: Icon(Icons.pie_chart_rounded))
      ],
      ),
      backgroundColor: Color.fromARGB(255, 74, 137, 60),
      body: DashChat(currentUser: user, onSend: (ChatMessage message){
        getData(message);
      }, messages: messageList,typingUsers: typing,),
    );
  }
}
