import 'package:auth/nextScreen/user/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login.dart';
import 'changePassword.dart';

class UserMain extends StatefulWidget {
  const UserMain({ Key? key }) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Profile(),
    ChangePassword()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome'),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) => Login(),
                ), (route) => false)
              },
            )
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Change Password'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}


///////////////////////////////////////////


///////////////////////////////////////////
