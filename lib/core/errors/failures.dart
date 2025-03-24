import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromFirebaseAuthException(
      FirebaseAuthException authException) {
    switch (authException.code) {
      case 'user-not-found':
        return ServerFailure('No user found with this email. Please register.');
      case 'wrong-password':
        return ServerFailure('Wrong password, please try again!');
      case 'email-already-in-use':
        return ServerFailure(
            'Email already in use, please try different email!');
      case 'invalid-credential':
        return ServerFailure('Wrong email or password, please try again!');
      default:
        return ServerFailure(authException.code);
    }
  }
}
