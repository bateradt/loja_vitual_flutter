import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('INiciando...');
//   await Firebase.initializeApp();
//   runApp(MyApp());


  // void _initializeFirebase() async {
  //   print('INiciando Firebase...');
  //   await Firebase.initializeApp();
  //   print('Iniciado...');
  // }
  //
  // _initializeFirebase();
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
        child: MaterialApp(
            title: 'Loja Virtual',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 4, 125, 141)),
            debugShowCheckedModeBanner: false,
            home: HomeScreen()
            // FutureBuilder(
            //   // Initialize FlutterFire
            //   future: Firebase.initializeApp(),
            //   builder: (context, snapshot) {
            //     print('snapshot :');
            //     print(snapshot.connectionState);
            //     if (snapshot.connectionState != ConnectionState.done) {
            //       print('Loading :');
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else {
            //       print('home :');
            //       // return LoginScreen();
            //       return HomeScreen();
            //     }
            //   },
            // )
        )
    );
  }
}
