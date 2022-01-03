import 'package:auth/services/auth.dart';
import 'package:flutter/material.dart';


//this is the UI for login screen
class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //auth is the instance of the authservices
  //it is created to access the properties of authservice class
  final AuthSerivce _auth = AuthSerivce();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        title: Text('Test SetUp'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () async{
            dynamic result = await _auth.signInAnon();
            if(result == null){
              print('error occured');
            }else{
              print('signed in');
              print(result.uid);
            }
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}