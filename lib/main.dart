
import 'package:auth/nextScreen/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

// void main(){
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        //incase the error occurs
        if(snapshot.hasError){
          print('Something went wrong.');
        }
        //incase of pending connection
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
          title: 'Set Up Test',
          theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login(),
        );
        }
        //incase of successful connection
        return CircularProgressIndicator();
      },
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<UserInformation?>.value(
//       value: AuthSerivce().user, //what stream we are going to listen to
//       initialData: null,
//       child: MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const Login(),
//       ),
//     );
//   }
// }