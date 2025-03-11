import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/RedirectionPage.dart';
import 'package:mediclinique/Authentification/SignupClinique.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
    Future<String> getUserRole(String userId)async{
    DocumentSnapshot userRef = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if(userRef.exists){
      return userRef['role'];
    }else{
      return 'clinique';
    }
  }

Future<void> login() async {
  setState(() {
    isLoading = true;
  });
  try {
    await Auth().SigninWithEmailAndPassword(email.text, password.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Redirectionpage()),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erreur de connexion: $e")),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  bool showpassword = false;
  

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/medii2.jpg",
                  width: largeurEcran,
                ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Svp connectez-vous pour continuer"),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                // email
                Container(
                  width: largeurEcran * 0.88,
                  height: 50,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.shade100,
                  ),
                  child: TextFormField(
                    controller: email,

                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email est obligatoire";
                      }
                      if (!value.contains('@')) {
                        return "L'email doit contenir un @";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email"),
                  ),
                ),

                //password
                Container(
                  width: largeurEcran * 0.88,
                  height: 50,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.shade100,
                  ),
                  child: TextFormField(
                    controller: password,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mot de passe obligatoire";
                      }
                      return null;
                    },
                    obscureText: !showpassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showpassword = !showpassword;
                          }),
                          icon: Icon(showpassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),

                SizedBox(
                  height: hauteurEcran * 0.01,
                ),
                // bouton de connexion
                Container(
                  width: largeurEcran * 0.88,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                          
                            });
                            if (formkey.currentState!.validate()) {
                              // Logique de connexion
                             login();
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            "Se connecter",
                            style: TextStyle(
                                fontSize: largeurEcran * 0.04,
                                color: Colors.white),
                          ),
                  ),
                ),
                //bouton d'inscription
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      "Pas de compte?",
                      style: TextStyle(fontSize: largeurEcran * 0.03),
                    ),
                    TextButton(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: largeurEcran * 0.03),
                      ),
                      onPressed: () => setState(() {
                        // naviguer vers la page d'inscription
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const Signupclinique()));
                      }),
                    )
                  ],
                ) /*ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Getstarted()));
                          },
                          style: ElevatedButton.styleFrom(
                          
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text('Retour', style: TextStyle(fontSize: 16)),
                        ),*/
              ],
            )),
      ),
    );
  }
}
