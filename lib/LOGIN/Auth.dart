import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;

  User({required this.uid});
}

class AuthBase {
  User? _userFromFirebase(User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(authResult.user as User);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(authResult.user as User);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
