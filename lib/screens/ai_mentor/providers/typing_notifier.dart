import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypingNotifier extends StateNotifier<List<ChatUser>>{
  TypingNotifier():super([]);

  void add(ChatUser user){
    state.add(user);
  }
  void remove(ChatUser user){
    state.remove(user);
  }



}