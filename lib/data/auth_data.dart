import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/firestore.dart';

abstract class AuthenticationDatasource {
  Future<String?> register(String email, String password, String passwordConfirm);
  Future<String?> login(String email, String password);
  Future<bool> emailExists(String email);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Login successful
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email format.';
      } else {
        return 'An unknown error occurred: ${e.message}';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  @override
  Future<String?> register(String email, String password, String passwordConfirm) async {
    if (passwordConfirm != password) {
      return 'Passwords do not match.';
    }

    if (!isValidPassword(password)) {
      return 'Password must contain uppercase letters, lowercase letters, and numbers.';
    }

    try {
      if (await emailExists(email)) {
        return 'The email is already in use.';
      }

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      await Firestore_Datasource().CreateUser(email);
      return null; // Registration successful
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The email is already in use.';
      } else {
        return 'An unknown error occurred: ${e.message}';
      }
    } catch (e) {
      return 'Invalid email format.';
    }
  }

  @override
  Future<bool> emailExists(String email) async {
    try {
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email.trim());
      return signInMethods.isNotEmpty;
    } catch (e) {
      throw Exception('An error occurred while checking email existence: $e');
    }
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    return passwordRegExp.hasMatch(password);
  }
}
