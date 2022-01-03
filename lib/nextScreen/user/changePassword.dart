import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = '';

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your password has been changed. Login Again!')));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'NewPassword',
                  hintText: 'Set New Password',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                controller: newPasswordController,
                validator: (value) {
                  if (value == null && value!.isEmpty) {
                    return 'Enter New Password';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      newPassword = newPasswordController.text;
                    });
                    changePassword();
                  }
                },
                child: Text('Change Password'))
          ],
        ),
      ),
    );
  }
}
