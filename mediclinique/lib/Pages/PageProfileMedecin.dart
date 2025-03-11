import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';
import 'package:mediclinique/Component/infoPerso.dart';
import 'package:mediclinique/Pages/FaqSupport.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class PageProfileMedecin extends StatefulWidget {
  const PageProfileMedecin({super.key});

  @override
  State<PageProfileMedecin> createState() => _PageProfileMedecin();
}

class _PageProfileMedecin extends State<PageProfileMedecin> {
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
        //uid = userDoc.get('uid');
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
    final largeurEcran = MediaQuery.of(context).size.height;
    return
      Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                width: MediaQuery.of(context).size.width,
                height: largeurEcran*0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      
                      //backgroundImage: AssetImage(" "),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text("Nom:$nom"),
                        Text("Adresse: $adresse")
                        //Text("N° compte: "),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoPerso()));
                    }, icon: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Autres paramètres",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  width: MediaQuery.of(context).size.width,
                  height: hauteurEcran*0.3,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.lock),
                        title: Text("Modifier mdp"),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.credit_card_sharp),
                        title: Text("Ma carte"),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.account_balance_wallet),
                        title: Text("Account Limits"),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  width: MediaQuery.of(context).size.width,
                  height: hauteurEcran*0.3,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.face),
                        title: Text("Biometrics"),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text("FAQ/Supports"),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const FAQPage()));
                            }, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Déconnexion"),
                        trailing: IconButton(
                            onPressed: () {
                              Auth().logout();
                          Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              ); // supprime les routes precedentes
                            }, icon: Icon(Icons.navigate_next)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
            ],
          ),
        ),
        )
      );
    
  }
}