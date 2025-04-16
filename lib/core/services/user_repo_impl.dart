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

  Future<Either<Failure, void>> updateUserProfile(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
