import 'package:auth/model/user.dart';
import 'package:auth/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //accessing the user data coming from stream through provider
    final user = Provider.of<UserInformation>(context);
    print(user);
    
    return Authenticate();
  }
}