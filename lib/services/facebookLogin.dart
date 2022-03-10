import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pinsmap/services/auth_result_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class facebook_login {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();            
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);          

      // Once signed in, return the UserCredential
      UserCredential result = await _auth.signInWithCredential(facebookAuthCredential);  
      User? user = result.user;
      print("facebook_user ${user}");
      return user != null ? user.getIdToken().toString() : null;
    } catch (e) {
      Fluttertoast.showToast(msg:"This Email ID is already Registered Using Google Sign In");      
      print("facebook_error${e}");
      return null;
    }
  }
}
