import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl {
  Future<Either<Failure, UserCredential>> register(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (authException) {
      return Left(ServerFailure.fromFirebaseAuthException(authException));
    }
  }

  Future<Either<Failure, UserCredential>> login(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (authException) {
      return Left(ServerFailure.fromFirebaseAuthException(authException));
    }
  }
}
