import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/Pages/HomeAdmin.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class Redirectionpage extends StatefulWidget{
  const Redirectionpage({super.key});

  @override
  State<Redirectionpage> createState() {
    return RedirectionpageState();
  }
}
class RedirectionpageState extends State<Redirectionpage>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange, 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasData){
          return const Home();
        }else{
          return const Login();
        }
      }
      );
  }
  
}