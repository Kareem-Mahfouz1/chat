import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

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

  Future<Either<Failure, UserModel>> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return Right(UserModel.fromMap(uid, doc.data()!));
      }
      return Left(ServerFailure('User not found'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }

  Future<Either<Failure, UserModel>> getUserByPhoneNumber(
      String phoneNumber) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return Right(UserModel.fromMap(doc.id, doc.data()));
      } else {
        return Left(ServerFailure('User not found'));
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }
}
