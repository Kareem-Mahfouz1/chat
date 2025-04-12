import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<Either<Failure, UserCredential>> register(
      String emailAddress, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthException(e));
    }
  }

  Future<Either<Failure, UserCredential>> login(
      String emailAddress, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthException(e));
    }
  }
}
