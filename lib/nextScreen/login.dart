import 'package:auth/nextScreen/forgetpassword.dart';
import 'package:auth/nextScreen/register.dart';
import 'package:auth/nextScreen/user/us_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain()));
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        print('No user found for that email address.');
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'No user found for that email address.',
                style: TextStyle(fontSize: 20.0),
              )));
      }else if(e.code =='wrong-password'){
        print('Wrong password.');
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Wrong password is entered.',
                style: TextStyle(fontSize: 20.0),
              )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color:Colors.red),
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Enter Email';
                    }else if(!value.contains('@')){
                      return 'enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  autofocus: false,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color:Colors.red),
                  ),
                  controller: passwordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Enter Password.';
                    }else if(value.length < 6){
                      return 'Password should be greater than 6.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: (){

                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      userLogin();
                    }
                  },
                  child: Text('Login'),
                ),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                }, child: Text('Forget Password')),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                }, child: Text("Don't have an account?"))
              ],
            ),
          )),
      ),
    );
  }
}