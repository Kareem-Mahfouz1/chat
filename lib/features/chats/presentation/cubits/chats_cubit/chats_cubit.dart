import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:chat/features/chats/data/repos/chats_repo_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.chatsRepoImpl) : super(ChatsInitial());
  final ChatsRepoImpl chatsRepoImpl;

  void streamUserChats() {
    emit(ChatsLoading());
    chatsRepoImpl.streamUserChats().listen((either) {
      either.fold((failure) {
        emit(ChatsFailure(errMessage: failure.errMessage));
      }, (chats) {
        emit(ChatsSuccess(chatList: chats));
      });
    });
  }
}
