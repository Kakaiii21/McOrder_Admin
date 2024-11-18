import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createSUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      throw Exception(_handleAuthError(e));
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      // Let the specific error message be handled
      throw _handleAuthError(e);
    } catch (e) {
      // Catch any unexpected errors
      throw 'An unknown error occurred. Please try again.';
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      // Print the error details to debug the issue
      print('FirebaseAuthException caught: ${error.code}, ${error.message}');
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use.';
        case 'wrong-password':
          return 'The password you entered is incorrect. Please try again.'; // More specific
        case 'user-not-found':
          return 'No user found with this email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'network-request-failed':
          return 'Network error. Please check your connection.';
        default:
          return 'An unknown error occurred: ${error.message}';
      }
    }
    print('Unknown error type: $error');
    return 'An unexpected error occurred. Please try again.';
  }
}
