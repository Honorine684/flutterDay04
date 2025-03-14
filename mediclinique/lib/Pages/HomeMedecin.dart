import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclinique/Authentification/SignupMedecin.dart';
import 'package:mediclinique/JsonModels/Rdv.dart';
import 'package:mediclinique/Pages/Consultation.dart';
import 'package:mediclinique/Pages/PageProfileMedecin.dart';
import 'package:mediclinique/Services/Firebase/FirestoreService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Rdv> rendezVous = [];
  String doctorId = "";

  @override
  void initState() {
    super.initState();
    // Récupérer le nom de l'utilisateur connecté
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        doctorId = user.uid;
      });
      // Charger les rendez-vous de l'utilisateur connecté
      loadRdv(doctorId);
    }
  }

  void loadRdv(String userName) {
    print("Démarrage du chargement des rdv pour $doctorId...");
    Firestoreservice().getRendezVous(doctorId).listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Rdv> RdvList = [];

      for (var doc in snapshot.docs) {
        try {
          String date = doc.get('date');
          String nomUser = doc.get('nomUser');
          String id = doc.id;
          RdvList.add(Rdv(id: id, date: date, nomUser: nomUser));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        rendezVous = RdvList;
      });
    }, onError: (error) {
      print("Erreur lors du chargement des rendez-vous: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final hauteurEcran = MediaQuery.of(context).size.height;
    final largeurEcran = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
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
              ),
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageProfileMedecin()));
                  },
                  icon: Icon(Icons.person)),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tableau de bord",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 130,
                      width: 160,
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
                                "26 patients",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 130,
                    width: 160,
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
                                  Icons.person,
                                  color: Colors.blue,
                                )),
                          ),
                          Text(
                            "23 rendez-vous",
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Vos rendez-vous",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: largeurEcran * 0.88,
                    height: hauteurEcran * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade100),
                    child: SizedBox(
                      height: hauteurEcran * 0.45,
                      child: ListView.builder(
                        itemCount: rendezVous.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            // Action lors du clic sur un rendez-vous
                            /*Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => DossierMedical(
        patientId: rendezVous[index].id,
        patientName: rendezVous[index].nomUser,  
      )
    )
  );*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AjoutConsultation(
                                          patientId: rendezVous[index].id,
                                          patientName:
                                              rendezVous[index].nomUser,
                                        )));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 10, top: 20),
                            width: largeurEcran * 0.6,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  rendezVous[index].date,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  rendezVous[index].nomUser,
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
