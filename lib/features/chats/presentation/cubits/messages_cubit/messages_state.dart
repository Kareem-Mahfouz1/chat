part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class MessagesLoading extends MessagesState {}

final class MessagesFailure extends MessagesState {
  final String errMessage;

  MessagesFailure({required this.errMessage});
}

final class MessageSendFailure extends MessagesState {
  final String errMessage;

  MessageSendFailure({required this.errMessage});
}

final class MessagesSuccess extends MessagesState {
  final List<Message> messageList;

  MessagesSuccess({required this.messageList});
}
