import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

void main() {
  runApp(MyApp());
  print('INiciando...');
  WidgetsFlutterBinding.ensureInitialized();
  // void _initializeFirebase() async {
  //   print('INiciando Firebase...');
  //   await Firebase.initializeApp();
  //   print('Iniciado...');
  // }
  //
  // _initializeFirebase();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Loja Virtual',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            print('snapshot :');
            print(snapshot.connectionState);
            if (snapshot.connectionState != ConnectionState.done) {
              print('Loading :');
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print('home :');
              return HomeScreen();
            }
          },
        ));
  }
}
