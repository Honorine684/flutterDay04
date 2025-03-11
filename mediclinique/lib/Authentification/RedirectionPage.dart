import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/Pages/HomeAdmin.dart';
import 'package:mediclinique/Pages/HomeClinique.dart';
import 'package:mediclinique/Pages/HomeMedecin.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Redirectionpage extends StatefulWidget {
  const Redirectionpage({super.key});

  @override
  State<Redirectionpage> createState() {
    return RedirectionpageState();
  }
}

class RedirectionpageState extends State<Redirectionpage> {
  // Méthode pour récupérer le rôle de l'utilisateur
  Future<String> getUserRole(String userId) async {
    DocumentSnapshot userRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    if (userRef.exists) {
      return userRef['role'];
    } else {
      return 'clinique'; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); 
        } else if (snapshot.hasData) {
          
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            return FutureBuilder(
              future: getUserRole(user.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); 
                } else if (roleSnapshot.hasData) {
                  String role = roleSnapshot.data as String;
                  // Rediriger en fonction du rôle
                  if (role == 'clinique') {
                    return const HomeClinique();
                  } else if (role == 'medecin') {
                    return const HomePage();
                  } else if (role == 'admin') {
                    return const Home();
                  } else {
                    return const Login(); 
                  }
                } else {
                  return const Login();
                }
              },
            );
          } else {
            return const Login();
          }
        } else {
          return const Login(); 
        }
      },
    );
  }
}