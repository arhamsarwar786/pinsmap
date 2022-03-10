import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/state_manager.dart';
import 'package:pinsmap/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinsmap/services/auth_result_exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResultStatus? _status;

  // User_data? _userFromFirebaseUser(User? user){
  //   return user != null ? User_data(uid: user.uid) : null;
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future CurrentUser() async {
    try {
      final User? user = await _auth.currentUser;
      String? usr = user != null ? user.getIdToken().toString() : null;
      print(usr);
      return usr;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null ? user.getIdToken().toString() : null;
    } catch (e) {
      print(e.toString());
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }
  }

  Future registerwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null ? user.getIdToken().toString() : null;
    } catch (e) {
      print(e.toString());
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }
  }

  Future changePassword(String oldpassword, String newpassword) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (googleSignIn.clientId == null) {
        User? user = await _auth.currentUser;

        String? email = await user?.email;

        final authCredential = await EmailAuthProvider.credential(
            email: email!, password: oldpassword);

        final authResult =
            await user?.reauthenticateWithCredential(authCredential);

        if (authResult != null) {
          return await user
              ?.updatePassword(newpassword)
              .then((value) => {print("Password Has been updated")})
              .catchError((e) {
            print("Somthing Wrong");
          });
        }
      } else {
        return "Google Login";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUserEmail() async {
    User? user = await _auth.currentUser;

    String? email = await user?.email;

    return email;
  }
}
