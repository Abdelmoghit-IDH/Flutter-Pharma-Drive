import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmadrive/model/user.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUpUser(UserModel user) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print("ouiiiiiiiiiiiiiiiiiii");
      return {
        'status': 200,
        'user': userCredential.user,
      };
    } catch (error) {
      print("nonnnnnnnnnnnnnnnnnnnn");
      print(error.message.toString()); 
      return {
        'status': 400,
        'error': error.message.toString(),
      };
    }
  }

  getCurrentUserEmail() {
    return _auth.currentUser.email;
  }

  signInUser(UserModel user) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print("ouiiiiiiiiiiiiiiiiiii");
      print(userCredential.user.uid);
      return {
        'status': 200,
        'userUid': userCredential.user.uid,
      };
    } catch (error) {
      print("nonnnnnnnnnnnnnnnnnnnn");
      print(error.message.toString()); 
      return {
        'status': 400,
        'error': error.message.toString(),
      };
    }
  }

  signOutUser() async {
    await _auth.signOut();
  }
}
