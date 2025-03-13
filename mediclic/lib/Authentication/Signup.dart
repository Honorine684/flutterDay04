import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclic/Authentication/Login.dart';
import 'package:mediclic/Component/BottomBar.dart';
import 'package:mediclic/Component/Photo.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final contact = TextEditingController();
  final ayantDroit = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  // Variables pour stocker l'image
  File? userImage;
  String? userImageBase64;
  // Méthode pour recevoir l'image du composant Photo
  void onImageSelected(File? imageFile, String? base64String) {
    setState(() {
      userImage = imageFile;
      userImageBase64 = base64String;
    });
  }

  // verification email et numero tel
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                             Image.asset(
                      "assets/image/login.jpg",
                      width: largeurEcran * 0.4,
                      height: hauteurEcran * 0.3,
                    ),
             Text("S'inscrire",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
             Text("Svp,inscrivez-vous pour continuer",style: TextStyle(fontSize: 13,),),

                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ce champ est obligatoire";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Nom complet",
                    ),
                  ),
                ),

                // email 

                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    validator: (value) => validateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: InputBorder.none,
                      hintText: "email",
                    ),
                  ),
                ),
                // photo
                Photo(onImageSelected: onImageSelected),
                // Nom Ayant droit
              Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: ayantDroit,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Nom Ayant Droit",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  
                  child: TextFormField(
                                        controller: contact,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.call),
                      border: InputBorder.none,
                      hintText: "Contact Ayant Droit",
                    ),
                  ),
                ),

                //password
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: password,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mot de passe obligatoire";
                      } else if ((password.text).length < 6) {
                        return "Le mot de passe doit contenir plus de 6 caractères";
                      } else if (!RegExp(r'[a-zA-Z]').hasMatch(password.text)) {
                        return "Le mot de passe doit contenir des lettres";
                      } else if (!RegExp(r'\d').hasMatch(password.text)) {
                        return "Le mot de passe doit contenir des nombres";
                      } else if ((password.text).contains(' ')) {
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
                // confirm password
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: confirmPassword,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirmer votre mot de passe";
                      } else if (password.text != confirmPassword.text) {
                        return "Les mots de passe ne correspondent pas";
                      }
                      return null;
                    },
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "confirm Password",
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
                  height: hauteurEcran * 0.02,
                ),
                // bouton d'inscription
                Container(
                  width: largeurEcran * 0.9,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                                 await Auth().createUserWithEmailAndPassword(
              name: name.text,
              email: email.text,
              password: password.text,
              photo: userImageBase64,
              nomAyantDroit: ayantDroit.text,
              contactAyantDroit: contact.text,
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
                                      builder: (context) =>
                                          const Bottombar()));
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
                      child: Text(
                        "Se connecter",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () => setState(() {
                        // naviguer vers la page de connexion
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    );
  }
}