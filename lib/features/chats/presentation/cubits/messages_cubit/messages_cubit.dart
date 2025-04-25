import 'dart:async';

import 'package:chat/features/chats/data/models/message_model.dart';
import 'package:chat/features/chats/data/repos/messages_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.messageRepoImpl) : super(MessagesInitial());
  final MessageRepoImpl messageRepoImpl;
  StreamSubscription? _sub;

  void streamMessages(String chatId) {
    emit(MessagesLoading());
    _sub?.cancel();
    _sub = messageRepoImpl.streamMessages(chatId).listen((result) {
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MessagesFailure(errMessage: failure.errMessage));
        },
        (messages) {
          emit(MessagesSuccess(messageList: messages));
        },
      );
    });
  }

  Future<void> sendMessage(String chatId, Message message) async {
    final result = await messageRepoImpl.sendMessage(chatId, message);
    result.fold(
      (failure) {
        emit(MessageSendFailure(errMessage: 'failure.errMessage'));
      },
      (_) {
        // if success don't do anything, the message will be shown automatically
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
