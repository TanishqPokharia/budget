import 'dart:convert';

import 'package:budget_buddy_2/main.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

class MessageListNotifier extends StateNotifier<List<ChatMessage>>{
  MessageListNotifier():super([]);
  final geminiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCMUQyaW4Ho7BNK63kGQR3SJucwgGd_GHA";
  final header = {
    "Content-Type": 'applications/json'
  };

  Future<void> updateMessageList(ChatMessage message) async{
    state.insert(0, message);
    await getGeminiResponse(message);
    print("1");
  }

  Future<void> getGeminiResponse(ChatMessage message) async {
    var data = {
      "contents": [{"parts": [{"text": message.text}]}]
    };

    try {
      var response = await http.post(Uri.parse(geminiUrl), headers: header, body: jsonEncode(data));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // ChatMessage chatMessage = ChatMessage(
        //   user: aiMentor,
        //   createdAt: DateTime.now(),
        //   text: result['candidates'][0]['content']['parts'][0]['text'],
        // );
        // state.insert(0, chatMessage);
      }
    } catch (e) {
      // Handle errors here
      print(e.toString());
    }
  }

}





