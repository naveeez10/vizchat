import 'package:firebase_auth/firebase_auth.dart';
import 'package:vizchat/helper/helper_function.dart';
import 'package:vizchat/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signinUserWithEmailandPassword(
      String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user.uid).updateUserData(fullname, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future signout() async {
    try{
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUsernameSF("");
      await firebaseAuth.signOut();
    }
    catch (e) {
      return null;
    }
  }
}
