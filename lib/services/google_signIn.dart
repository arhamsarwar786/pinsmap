import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future GoogleSignUp() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    print('${googleSignIn} Google Error');
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();          
    print(googleSignInAccount);
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
          print('${googleSignInAuthentication} Authentication');
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
        print('${authCredential}AuthCredential');
      // Getting users credential      
      UserCredential result = await _auth.signInWithCredential(authCredential);  
      User? user = result.user;
      return user != null ? user.getIdToken().toString() : null;
    }
  }
}