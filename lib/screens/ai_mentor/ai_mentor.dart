import 'dart:convert';

import 'package:budget_buddy_2/main.dart';
import 'package:budget_buddy_2/screens/ai_mentor/providers/message_list_provider.dart';
import 'package:budget_buddy_2/screens/ai_mentor/providers/typing_provider.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class AIMentorScreen extends ConsumerWidget{
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 12, 12, 26),
//       body: DashChat(currentUser: chatUser, onSend: (ChatMessage message) async{
//           ref.watch(typingProvider.notifier).add(aiMentor);
//          await ref.watch(messageListStateProvider.notifier).updateMessageList(message);
//           ref.watch(typingProvider.notifier).remove(aiMentor);
//           print(message.text);
//       }, messages: ref.watch(messageListStateProvider),
//       typingUsers: ref.watch(typingProvider),),
//     );
//   }
// }
// class AIMentorScreen extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return AIMentorScreenState();
//   }
// }
// class AIMentorScreenState extends State<AIMentorScreen>{
//   final List<ChatMessage> allMessages = [];
//   final List<ChatUser> typing = [];
//   final geminiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCMUQyaW4Ho7BNK63kGQR3SJucwgGd_GHA";
//   final header = {
//     "Content-Type": 'applications/json'
//   };
//
//   getData(ChatMessage message) async{
//     typing.add(aiMentor);
//     allMessages.insert(0, message);
//     print("1");
//     var data = {
//       "contents": [{"parts": [{"text": message.text}]}]
//     };
//
//     try {
//       var response = await http.post(Uri.parse(geminiUrl), headers: header, body: jsonEncode(data));
//       if (response.statusCode == 200) {
//         var result = jsonDecode(response.body);
//         ChatMessage chatMessage = ChatMessage(
//           user: aiMentor,
//           createdAt: DateTime.now(),
//           text: result['candidates'][0]['content']['parts'][0]['text'],
//         );
//         allMessages.insert(0, chatMessage);
//       }
//     } catch (e) {
//       // Handle errors here
//       print(e.toString());
//     }
//     typing.remove(aiMentor);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 12, 12, 26),
//       body: DashChat(currentUser: chatUser, onSend: (ChatMessage message) async{
//         getData(message);
//         print(message.text);
//       }, messages: allMessages,
//         typingUsers: typing),
//     );
//   }
// }
