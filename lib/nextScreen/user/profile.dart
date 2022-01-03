import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser; //for null safety we should write ?

  verifyEmail() async{
    if(user != null && !user!.emailVerified){
      await user!.sendEmailVerification();
      print('Email Verification has been sent.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Verification has been sent to your email.')));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('User ID: $uid'),
        Row(
          children: [ 
            Text('Email: $email'),
            user!.emailVerified ? Text('verified') : 
            TextButton(onPressed: (){
              verifyEmail();
            }, child: Text('Verify Email', style: TextStyle(color: Colors.blue),))
          ],
        ),
        Text('Created Date: $creationTime')
      ],),
    );
  }
}
