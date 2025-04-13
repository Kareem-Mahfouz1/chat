part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class ChatsFailure extends ChatsState {
  final String errMessage;

  ChatsFailure({required this.errMessage});
}

final class ChatsSuccess extends ChatsState {
  final List<ChatModel> chatList;

  ChatsSuccess({required this.chatList});
}
