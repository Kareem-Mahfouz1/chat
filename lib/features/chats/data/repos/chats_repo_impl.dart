import 'package:chat/core/errors/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_model.dart';
import 'package:dartz/dartz.dart';

class ChatsRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Either<Failure, List<ChatModel>>> streamUserChats() {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final stream = _firestore
          .collection('chats')
          .where('participants', arrayContains: userId)
          .orderBy('lastUpdated', descending: true)
          .snapshots()
          .map((snapshot) {
        final chats =
            snapshot.docs.map((doc) => ChatModel.fromDoc(doc)).toList();
        return Right<Failure, List<ChatModel>>(chats);
      });

      return stream;
    } catch (e) {
      return Stream.value(
        Left(ServerFailure("Failed to stream chats: ${e.toString()}")),
      );
    }
  }

  Future<Either<Failure, ChatModel>> getOrCreateChat(
      String contactPhoneNumber) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      // Find the contact's UID by phone
      final contactQuery = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: contactPhoneNumber)
          .limit(1)
          .get();

      final otherUserDoc = contactQuery.docs.first;
      final otherUserId = otherUserDoc.id;

      // Check if a chat already exists
      final existing = await _firestore
          .collection('chats')
          .where('participants', arrayContains: userId)
          .get();

      for (final doc in existing.docs) {
        final participants = List<String>.from(doc['participants']);
        if (participants.contains(otherUserId) && participants.length == 2) {
          return Right(ChatModel.fromDoc(doc));
        }
      }

      // Create new chat
      final otherUserName = otherUserDoc['displayName'];
      final currentUserName = (await _firestore
          .collection('users')
          .doc(userId)
          .get())['displayName'];

      final chatRef = await _firestore.collection('chats').add({
        'participants': [userId, otherUserId],
        'lastMessage': '',
        'lastUpdated': FieldValue.serverTimestamp(),
        'participantNames': {
          userId: currentUserName,
          otherUserId: otherUserName,
        }
      });

      final chatDoc = await chatRef.get();
      final chat = ChatModel.fromDoc(chatDoc);

      return Right(chat);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
