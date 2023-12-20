import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user_model.dart';
import 'firebase_service.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (error) {
      rethrow;
    }
  }

  Future<User?> signUpWithEmailPassword(
      String email, String password, String userName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          email: user.email,
          userName: userName,
        );

        await _firebaseService.addUser(newUser);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          await _firebaseService.updateUser(
            UserModel(
              id: user.uid,
              email: user.email,
              userName: user.displayName,
              photoUrl: user.photoURL,
            ),
          );
          return user;
        }
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }
}
