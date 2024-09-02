import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/firestore.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String passwordConfirm);
  Future<bool> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email format.');
      } else {
        print('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    return false;
  }

  @override
  Future<void> register(
      String email, String password, String passwordConfirm) async {
    if (passwordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((Value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }
}
