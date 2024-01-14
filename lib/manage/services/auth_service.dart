import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../apps/helper/showToast.dart';
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
          role: "isUser",
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
          UserModel? userModel = await FirebaseService().getUser(user.uid);
          if (userModel != null) {
            // await _firebaseService.updateUser(userModel);
          } else {
            await _firebaseService.updateUser(
              UserModel(
                id: user.uid,
                email: user.email,
                userName: user.displayName,
                photoUrl: user.photoURL,
              ),
            );
          }
          return user;
        }
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  Future<void> changePassword(String newPassword) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("Không tìm thấy người dùng");
    }

    try {
      await user.updatePassword(newPassword);
      showToastSuccess("Đổi mật khẩu thành công");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception("Yêu cầu đăng nhập lại để đổi mật khẩu");
      }
      rethrow;
    }
  }
}
