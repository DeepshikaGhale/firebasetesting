import 'package:auth/nextScreen/login.dart';
import 'package:auth/nextScreen/user/us_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var username = '';
  var confirmpassword = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  registration() async {
    if (password == confirmpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registered Successfully. Logged in...',
              style: TextStyle(fontSize: 20.0),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const UserMain()));
            //
      } on FirebaseAuthException catch (e) {
        //
        if (e.code == 'weak-password') {
          print('Password provided is too weak.');
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Password provided is too weak.',
                style: TextStyle(fontSize: 20.0),
              )));
        } 
        //
        else if (e.code == 'email-already-in-use') {
          print('Account already exists.');
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Account already exists.',
                style: TextStyle(fontSize: 20.0),
              )));
        }
        //
        print(e.toString());
      }
    } 
    //
    else {
      print('Password and Confirm Password does not match.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
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
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email';
                      } else if (!value.contains('@')) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      label: Text('Username'),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Username';
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
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password.';
                      } else if (value.length < 6) {
                        return 'Password should be greater than 6.';
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
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password.';
                      } else if (value.length < 6) {
                        return 'Password should be greater than 6.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          username = usernameController.text;
                          password = passwordController.text;
                          confirmpassword = confirmPasswordController.text;
                        });
                        registration();
                      }
                    },
                    child: Text('Register'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Already have an account?"))
                ],
              ),
            )),
      ),
    );
  }
}
