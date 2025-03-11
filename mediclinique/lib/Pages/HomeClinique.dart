import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/Authentification/SignupMedecin.dart';
import 'package:mediclinique/Pages/PageProfileClinique.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class HomeClinique extends StatefulWidget {
  const HomeClinique({super.key});

  @override
  State<HomeClinique> createState() {
    return HomeCliniqueState();
  }
}

class HomeCliniqueState extends State<HomeClinique> {
  String nom = '';
String adresse = '';
String email = '';
String uid = '';
Future<void> getUserData()async{
  try{
    final User? currentUser = Auth().currentUser;
    DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
    if(userDoc.exists){
      setState(() {
       // uid = currentUser.uid;
        nom = userDoc.get('username')?? '';
        adresse = userDoc.get('adresse')?? '';
        email = currentUser.email??'';
      });
    }
  }catch(e){
    print("erreur lors de la recupération de l'user $e");
  }
}
@override
  void initState() {
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                "Mediclinique",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Icon(
                Icons.health_and_safety,
                color: Colors.blue,
              )
            ],
          ),
          actions: [
            Text(adresse)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nous faisons de la santé\n notre priorité",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                    child:
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PageProfile()));
                        }, icon: Icon(Icons.person)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Accès rapide",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: hauteurEcran * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 120,
                      width: 150,
                      child: Card(
                          elevation: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF6CFF3).withOpacity(0.2)),
                                child: IconButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajoutspecialite()));
                                    },
                                    icon: Icon(
                                      Icons.person,
                                      color: Color(0xffF6CFF3),
                                    )),
                              ),
                              Text(
                                "26 docteurs",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 120,
                    width: 150,
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade100),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signupmedecin()));
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                )),
                          ),
                          Text(
                            "Ajouter médécin",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 120,
                      width: 150,
                      child: Card(
                          elevation: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF6CFF3).withOpacity(0.2)),
                                child: IconButton(
                                    onPressed: () {
                                      Auth().logout();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                        (route) => false,
                                      ); // supprime les routes precedentes
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                      color: Color(0xffF6CFF3),
                                    )),
                              ),
                              Text(
                                "Déconnexion",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 120,
                    width: 150,
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade100),
                            child: IconButton(
                                onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajoutclinique()));
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                )),
                          ),
                          Text(
                            "100 patients",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Actualités",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: hauteurEcran * 0.02,
              ),
              SizedBox(
                height: hauteurEcran * 0.13,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  SizedBox(
                      height: 80,
                      width: 170,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Arrivée du Dr HOnorine",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Notre équipe s'agrandit",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                      height: 80,
                      width: 190,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Vaccination COVID rappel",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Campagne disponible ",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )),
                      SizedBox(
                      height: 80,
                      width: 190,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Rappel du jour",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Garde le 1er juin",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ))
                ]),
              )
            ],
          ),
        ));
  }
}
