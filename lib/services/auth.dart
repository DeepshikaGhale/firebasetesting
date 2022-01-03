import 'package:auth/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSerivce{
  
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  //create user obj based on firebase user
  UserInformation? _userFromFirebaseUser(User? user){
    return user != null ? UserInformation(uid: user.uid) : null;
  }

  Stream<UserInformation?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user; // gives access to the user
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password

  //register with email & password

  //logout
}