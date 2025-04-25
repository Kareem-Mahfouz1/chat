import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/chats/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class MessageRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Either<Failure, List<Message>>> streamMessages(String chatId) {
    try {
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        final messages =
            snapshot.docs.map((doc) => Message.fromDoc(doc)).toList();
        return Right<Failure, List<Message>>(messages);
      });
    } on FirebaseException catch (e) {
      return Stream.value(Left(ServerFailure.fromFirebaseException(e)));
    } catch (e) {
      return Stream.value(
          Left(ServerFailure("Unexpected error: ${e.toString()}")));
    }
  }

  Future<Either<Failure, void>> sendMessage(
      String chatId, Message message) async {
    try {
      final chatRef = _firestore.collection('chats').doc(chatId);
      final userId = message.senderId;

      await chatRef.collection('messages').add(message.toMap());

      final chatDoc = await chatRef.get();
      final data = chatDoc.data()!;
      final participants = List<String>.from(data['participants']);
      final unreadCounts =
          Map<String, dynamic>.from(data['unreadCounts'] ?? {});
      final inChat = Map<String, dynamic>.from(data['inChat'] ?? {});

      for (var participant in participants) {
        if (participant != userId) {
          final isOtherInChat = inChat[participant] ?? false;
          if (!isOtherInChat) {
            unreadCounts[participant] = (unreadCounts[participant] ?? 0) + 1;
          }
        }
      }

      await chatRef.update({
        'lastMessage': message.text,
        'lastUpdated': FieldValue.serverTimestamp(),
        'unreadCounts': unreadCounts,
      });

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
