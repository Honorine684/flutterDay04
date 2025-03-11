import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/JsonModels/JourDisponibilite.dart';
import 'package:mediclinique/Pages/HomeClinique.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class Signupclinique extends StatefulWidget {
  const Signupclinique({super.key});

  

  @override
  State<Signupclinique> createState() {
    return SignupcliniqueState();
  }
}

class SignupcliniqueState extends State<Signupclinique> {
  final formKey = GlobalKey<FormState>();
  //controller de texte
  final username = TextEditingController();
  final email = TextEditingController();
  final passWord = TextEditingController();
  final adresse = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;
  List<Jourdisponibilite> doctorAvailability = []; 
  // verification email
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value!.isNotEmpty && !regex.hasMatch(value)) {
      return "Entrez un email valide";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // images
                Image.asset(
                  "assets/images/medii1.jpeg",
                  width: largeurEcran ,
                ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Svp inscrivez-vous pour continuer"),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                // Nom clinique
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
                    controller: username,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nom clinique est obligatoire";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Nom clinique"),
                  ),
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
                    validator: validateEmail,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email"),
                  ),
                ),
                // adresse
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
                    controller: adresse,
                    
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Adresse(optionnel)"),
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
                    controller: passWord,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mot de passe obligatoire";
                      } else if ((passWord.text).length < 6) {
                        return "Le mot de passe doit contenir plus de 6 caractères";
                      } else if (!RegExp(r'[a-zA-Z]').hasMatch(passWord.text)) {
                        return "Le mot de passe doit contenir des lettres";
                      } else if (!RegExp(r'\d').hasMatch(passWord.text)) {
                        return "Le mot de passe doit contenir des nombres";
                      } else if ((passWord.text).contains(' ')) {
                        return "Le mot de passe ne peut contenir d'espace";
                      }
                      return null;
                    },
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showPassword = !showPassword;
                          }),
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                //confirmpassword
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
                    controller: confirmPassword,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirmer votre mot de passe";
                      } else if (passWord.text != confirmPassword.text) {
                        return "Les mots de passe ne correspondent pas";
                      }
                      return null;
                    },
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          }),
                          icon: Icon(showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                SizedBox(
                  height: hauteurEcran * 0.01,
                ),
              
                // bouton d'inscription
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
                            if (formKey.currentState!.validate()) {
                              // Logique de connexion
                              try {
                                Auth().inscrireClinique(
                                  username.text,
                                  adresse.text,
                                  email.text,
                                  passWord.text,
                                  
                                  
                                );
                                setState(() {
                                  isLoading = false;
                                });
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                // message d'erreur
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${e.message}"),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Color(0xffE9494F),
                                    showCloseIcon: true,
                                  ),
                                );
                              }
                              // naviguer vers la page home
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeClinique()));
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            "S'inscrire",
                            style: TextStyle(
                                fontSize: largeurEcran * 0.04,
                                color: Colors.white),
                          ),
                  ),
                ),
                //bouton de connexion

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Vous êtes utilisateur?"),
                    TextButton(
                      child: Text("Se connecter"),
                      onPressed: () => setState(() {
                        // naviguer vers la page de connexion
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
