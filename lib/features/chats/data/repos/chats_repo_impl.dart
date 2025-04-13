import 'package:chat/core/errors/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_model.dart';
import 'package:dartz/dartz.dart';

class ChatsRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Either<Failure, List<ChatModel>>> streamUserChats() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
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
}
