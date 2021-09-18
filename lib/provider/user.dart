import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:padcom/models/user_model.dart';


// Ito yung irereturn pag nag login
// pag addinfo = need to sign up
// pag okay = pasok na agad sa home
enum LoginSuccessStatus { ok, addInfo }

class UserProvider {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin = FacebookLogin();
  final CollectionReference userDetailsCollection = FirebaseFirestore.instance.collection("UserDetails");

  UserProvider({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  // Stream<User> get user {
  //   return _firebaseAuth.authStateChanges().map((firebaseUser) {
  //     if (firebaseUser == null) {
  //       return User.empty;
  //     }

  //     return firebaseUser.toUser;
  //   });
  // }

  Future<LoginSuccessStatus> loginWithEmailAndPassword({@required String email, @required String password}) async {
    assert(email != null && password != null);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return LoginSuccessStatus.ok;
    } on Exception catch(error){
      throw error;
    }
  }

  Future<LoginSuccessStatus> logInWithFacebook() async {
    try {
      final FacebookLoginResult facebookLoginResult = await _facebookLogin.logIn(['email']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.loggedIn:
          if (facebookLoginResult.accessToken == null) {
            throw Exception("Access token is null");
          }

          final firebase_auth.AuthCredential fbCredential = firebase_auth.FacebookAuthProvider.credential(facebookLoginResult.accessToken.token);
          // final token = facebookLoginResult.accessToken.token;
          // final graphResponse = await http.get(Uri.parse("https://graph.facebook.com/v2.12/me?fields=name,picture,first_name,last_name,email&access_token=$token"));
          // final profile = json.decode(graphResponse.body);

          // if (profile['email'] == null) {
          //   throw Exception("Email from facebook is null");
          // }

          final firebase_auth.User user = await _firebaseAuth.signInWithCredential(fbCredential).then((userCredential) {
            return userCredential.user;
          });

          // Success
          return LoginSuccessStatus.ok;
          break;
        case FacebookLoginStatus.cancelledByUser:
          throw Exception("Cancelled by User");
          break;
        case FacebookLoginStatus.error:
          throw Exception("Facebook error");
          break;
      }

      return LoginSuccessStatus.ok;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<LoginSuccessStatus> logInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final firebase_auth.AuthCredential googleCredential = firebase_auth.GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
      Map<String, dynamic> profile = parseJwt(googleSignInAuthentication.idToken);
      final String email = profile["email"];

      // If no existing email, create new account then return user
      // check kung addinfo status nya o walang user details, tapos papuntahin sa signup
      var checkEmails = await userDetailsCollection.where('account.email', isEqualTo: email).get();
      if (checkEmails.docs.isEmpty) {
        await _firebaseAuth.signInWithCredential(googleCredential);

        // final UserDetail userDetail = await this.currentUserDetails;
        // if(userDetail == UserDetail.empty || userDetail.status == "addInfo"){
        return LoginSuccessStatus.addInfo;
        // }

        // status ok
        // return LoginSuccessStatus.ok;
      }

      var signUpTypeFromDoc = checkEmails.docs[0].get("account.signUpType");
      var emailFromDoc = checkEmails.docs[0].get("account.email");
      if (signUpTypeFromDoc != 'google' && emailFromDoc != email) {
        throw Exception("Email already in use");
      }

      await _firebaseAuth.signInWithCredential(googleCredential);

      return LoginSuccessStatus.ok;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<User> normalSignUp({String email, String password}) async {
    try {
      final firebase_auth.User user = 
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: password)
          .then((userCredential) {
            return userCredential.user;
          });
      return user.toUser;
    } on Exception catch (error) {
      throw error;
    }
  }

  // Future<User> googleSignUp(User userDetail) async {
  //   try {
  //     final batch = FirebaseFirestore.instance.batch();

  //     // Get current user from login
  //     final user = _firebaseAuth.currentUser;
      
  //     // Get user photoUrl then store to user details
  //     userDetail.details.photo = (user.photoURL ?? "") +
  //       (user.photoURL != null && user.photoURL != "" ? "?height=150" : "");

  //     batch.set(userDetailsCollection.doc(user.uid), userDetail.toSignUp());

  //     await batch.commit();

  //     return user.toUser;
  //   } on Exception {
  //     throw Exception("Sign Up Failure");
  //   }
  // }

  // Future<User> facebookSignUp(User userDetail) async {
  //   // try {
  //     final batch = FirebaseFirestore.instance.batch();

  //     // Get current user from login
  //     final user = _firebaseAuth.currentUser;

  //     // Get user photoUrl then store to user details
  //     userDetail.details.photo = (user.photoURL ?? "") +
  //       (user.photoURL != null && user.photoURL != "" ? "?height=150" : "");

  //     batch.set(userDetailsCollection.doc(user.uid), userDetail.toSignUp());

  //     await batch.commit();

  //     return user.toUser;
  //   // } on Exception {
  //   //   throw Exception("Sign Up Failure");
  //   // }
  // }

  // Future<bool> checkIfEmailExists({@required String email, @required SignUpTypes signUpType}) async {
  //   // convert enum type to string value
  //   var signUpTypeString = signUpType == SignUpTypes.Google
  //       ? "google.com"
  //       : signUpType == SignUpTypes.Facebook
  //           ? "facebook.com"
  //           : "";

  //   try {
  //     // compare signup type from user sign in method for facebook and google to
  //     final checkAuthEmails = await _firebaseAuth.fetchSignInMethodsForEmail(email);
  //     if (checkAuthEmails.isNotEmpty && (checkAuthEmails[0] != signUpTypeString)) {
  //       return true;
  //     }

  //     final userAccountDoc = await userDetailsCollection.where('email', isEqualTo: email).get();

  //     if (userAccountDoc.docs.isNotEmpty) {
  //       return true;
  //     }

  //     return false;
  //   } on Exception catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> logout() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw Exception("Log out Failure");
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid, 
      email: email
      );
  }
}
