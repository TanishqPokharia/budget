import 'dart:convert';

import 'package:budget_buddy_2/responsive/responsive.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsightPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InsightPageState();
  }
}

class InsightPageState extends State<InsightPage>{
  ChatUser user = ChatUser(id: "1",firstName: "Tanishq");
  ChatUser aiMentor = ChatUser(id: "2",firstName: "Analzyer");
  List<ChatMessage> messageList = [];
  List<ChatUser> typing = [];
  FilePickerResult? pickedPdf = null;
  pickPdf() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return ;
    }
    setState(() {
      pickedPdf = result;
    });
  }

  getPdfData(ChatMessage message) async {
    typing.add(aiMentor);
    messageList.insert(0, message);
    final dio = Dio();
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(pickedPdf!.files.single.path!,filename: 'pdf'),
      'query': " What is the project's name ",
    });

    final response = await dio.post("https://hypeconqueror1-budgetbuddypdfchat.hf.space/PromptBuddy",data: formData);
    await dio.post("https://hypeconqueror1-budgetbuddypdfchat.hf.space/PromptBuddy",data: formData).then((
        value) {
      if (value.statusCode == 200) {
        var result = value.toString();
        ChatMessage chatMessage = ChatMessage(
          user: aiMentor,
          createdAt: DateTime.now(),
          text: value.toString(),
        );
        messageList.insert(0, chatMessage);
      }
    }).catchError((error) {
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
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
                pickPdf();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal:Responsive.size(context, 30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add PDF"),
                  SizedBox(width: Responsive.size(context, 10),),
                  Icon(Icons.picture_as_pdf)
                ],
              ),
            ),
          )
        ],
      ),
      body: DashChat(currentUser: user,onSend: (ChatMessage message){
        getPdfData(message);
      },messages: messageList,typingUsers: typing,
      ),
    );
  }
}
