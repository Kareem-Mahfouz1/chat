import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, void>> createUserInFirestore({
    required String uid,
    required String email,
    required String displayName,
    required String phoneNumber,
  }) async {
    try {
      final docRef = _firestore.collection('users').doc(uid);

      await docRef.set({
        'email': email,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }

  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return Right(UserModel.fromMap(uid, doc.data()!));
      }
      return Left(ServerFailure('User not found'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }

  Future<Either<Failure, void>> deleteUserAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;

      await _firestore.collection('users').doc(uid).delete();

      await user.delete();

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateUserProfile(UserModel newUser) async {
    try {
      final uid = newUser.uid;
      final newName = newUser.displayName;
      final newPhone = newUser.phoneNumber;

      final userRef = _firestore.collection('users').doc(uid);

      // 1. Update user document
      await userRef.update(newUser.toMap());

      // 2. Update all participantNames in chats
      final chatDocs = await _firestore
          .collection('chats')
          .where('participants', arrayContains: uid)
          .get();

      for (final doc in chatDocs.docs) {
        await doc.reference.update({
          'participantNames.$uid': newName,
        });
      }

      // 3. Update contact lists in all users
      final allUsers = await _firestore.collection('users').get();

      for (final userDoc in allUsers.docs) {
        final data = userDoc.data();
        final contacts = (data['contacts'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();

        final updatedContacts = contacts.map((contact) {
          if (contact['uid'] == uid) {
            return {
              'uid': uid,
              'name': newName,
              'phoneNumber': newPhone,
            };
          }
          return contact;
        }).toList();
        await userDoc.reference.update({'contacts': updatedContacts});
      }

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
