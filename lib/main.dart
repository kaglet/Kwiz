import 'package:kwiz/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kwiz/firebase_options.dart';

// <<<<<<< HEAD
// void main() => runApp(MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         scaffoldBackgroundColor: Color.fromARGB(255, 49, 49, 49),
//         textTheme: TextTheme(
//           headline1: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//           headline2: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//           bodyText2: TextStyle(color: Color.fromARGB(255, 238, 238, 238)),
//           subtitle1: TextStyle(color: Color.fromARGB(167, 157, 199, 123)),
//         )
// =======

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //String qID = 'TJvZqgQaVC9LkBqeVqlL';

  runApp(MaterialApp(
  theme: ThemeData(
    appBarTheme:  const AppBarTheme(
      color: Color.fromARGB(255, 27, 57, 82),
      iconTheme: IconThemeData(color: Colors.white), 
  
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
  ),
  home: const Home(),
));

}
