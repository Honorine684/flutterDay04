import 'package:flutter/material.dart';
import 'package:mediclic/Authentication/Login.dart';
import 'package:mediclic/Component/BottomBar.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';


class Redirectionpage extends StatefulWidget {
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
    stream: Auth().authStateChanges, 
    builder:(context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }else if(snapshot.hasData){
        return const Bottombar();
      }else{
        return const Login();
      }
    }
    );
  }
  
}