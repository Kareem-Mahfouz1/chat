import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastUpdated;
  final Map<String, String> participantNames;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastUpdated,
    required this.participantNames,
  });

  factory ChatModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      participantNames:
          Map<String, String>.from(data['participantNames'] ?? {}),
    );
  }
}
