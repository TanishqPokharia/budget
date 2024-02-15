import 'package:budget_buddy_2/screens/ai_mentor/providers/message_list_notifier.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageListStateProvider = StateNotifierProvider<MessageListNotifier,List<ChatMessage>>((ref) => MessageListNotifier());