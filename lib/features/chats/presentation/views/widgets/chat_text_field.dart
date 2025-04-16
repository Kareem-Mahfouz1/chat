import 'package:chat/constants.dart';
import 'package:chat/features/chats/data/models/message_model.dart';
import 'package:chat/features/chats/presentation/cubits/messages_cubit/messages_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Message',
                contentPadding: const EdgeInsets.only(left: 20),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            padding: const EdgeInsets.all(13),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Icons.send,
            ),
            onPressed: () async {
              final text = messageController.text.trim();
              if (text.isNotEmpty) {
                final msg = Message(
                  id: '', // Firestore will assign this
                  text: text,
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  timestamp: DateTime.now(),
                );
                print('------------------------------done 1');
                await context
                    .read<MessagesCubit>()
                    .sendMessage(widget.chatId, msg);
                print('------------------------------done 2');
                messageController.clear();
                print('------------------------------done 3');
              }
            },
          )
        ],
      ),
    );
  }
}
