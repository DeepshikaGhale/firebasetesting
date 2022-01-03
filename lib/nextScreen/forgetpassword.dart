import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = '';

  final emailController = TextEditingController();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Check you email for resetting your password.',
                style: TextStyle(fontSize: 20.0),
              )));
    } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'No user found for that email.',
                style: TextStyle(fontSize: 20.0),
              )));
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password'), centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
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
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        email = emailController.text;
                      });
                      resetPassword();
                    }
                  },
                  child: Text('Change Password'),
                ),
                ],
              ),
            )),
      ),
    );
  }
}
