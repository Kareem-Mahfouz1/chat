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

    DateTime lastUpdated;

    final raw = data['lastUpdated'];
    if (raw is Timestamp) {
      lastUpdated = raw.toDate();
    } else {
      lastUpdated = DateTime.now(); // fallback
    }

    return ChatModel(
      chatId: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastUpdated: lastUpdated,
      participantNames:
          Map<String, String>.from(data['participantNames'] ?? {}),
    );
  }
}
