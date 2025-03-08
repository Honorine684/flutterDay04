import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
   runApp(MaterialApp(
   home: Login(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor:Color(0xffF6CFF3),
     // primarySwatch: Colors.teal,
      colorScheme: ColorScheme.light(
     primary: Color(0xffE5B769), 
    ),)));
}

