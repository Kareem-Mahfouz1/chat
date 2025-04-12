import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return ServerFailure('No user found with this email. Please register.');
      case 'wrong-password':
        return ServerFailure('Wrong password, please try again!');
      case 'email-already-in-use':
        return ServerFailure(
            'Email already in use, please try a different email!');
      case 'invalid-credential':
        return ServerFailure('Wrong email or password, please try again!');
      default:
        return ServerFailure(e.message ?? 'An unknown auth error occurred.');
    }
  }

  factory ServerFailure.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return ServerFailure(
            "You don’t have permission to perform this action.");
      case 'unavailable':
        return ServerFailure("Service unavailable. Try again later.");
      case 'not-found':
        return ServerFailure("Data not found.");
      case 'already-exists':
        return ServerFailure("This record already exists.");
      case 'invalid-argument':
        return ServerFailure("Invalid data provided.");
      case 'unauthenticated':
        return ServerFailure("You need to be logged in.");
      case 'deadline-exceeded':
        return ServerFailure("Request timed out. Check your connection.");
      default:
        return ServerFailure(
            e.message ?? 'An unknown Firestore error occurred.');
    }
  }
}
