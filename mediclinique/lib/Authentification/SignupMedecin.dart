import 'package:flutter/material.dart';
import 'package:mediclinique/Component/Step1.dart';
import 'package:mediclinique/Component/Step2.dart';
import 'package:mediclinique/Component/Step3.dart';
import 'package:mediclinique/Component/Step4.dart';
import 'package:mediclinique/Component/Step5.dart';
import 'package:mediclinique/JsonModels/JourDisponibilite.dart';
import 'package:mediclinique/Services/Firebase/Auth.dart';

class Signupmedecin extends StatefulWidget {
  const Signupmedecin({super.key});

  @override
  State<Signupmedecin> createState() {
    return SignupmedecinState();
  }
}

class SignupmedecinState extends State<Signupmedecin> {
  int initialStep = 0;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  Map<String, dynamic> medecinData = {};

  // Collecter les données de chaque étape
  void getStep1Data(Map<String, dynamic> data) {
    setState(() {
      medecinData.addAll(data);
    });
  }

  void getStep2Data(Map<String, dynamic> data) {
    medecinData.addAll(data);
  }

  void getStep3Data(Map<String, dynamic> data) {
    medecinData.addAll(data);
  }

  void getStep5Data(Map<String, dynamic> data) {
    medecinData.addAll(data);
  }

  late List<Step> steps;

  @override
  void initState() {
    super.initState();
    // Initialisation des étapes
    steps = [
      Step(
        title: Text("Informations personnelles",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Step1(onDataChanged: getStep1Data),
        isActive: true,
      ),
      Step(
        title: Text("Encore sur vous",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Step2(onDataChanged: getStep2Data),
        isActive: true,
      ),
      Step(
        title: Text("Informations professionnelles",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Step3(onDataChanged: getStep3Data),
        isActive: true,
      ),
      Step(
        title: Text("Disponibilités",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Step5(onDataChanged: getStep5Data),
        isActive: true,
      ),
      Step(
        title: Text("Confirmation",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Step4(),
        isActive: true,
        state: StepState.complete,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final hauteurEcran = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text("Ajouter un medecin",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: hauteurEcran * 0.02),
          Stepper(
            currentStep: initialStep,
            type: StepperType.vertical,
            steps: steps,
            onStepTapped: (value) {
              setState(() {
                initialStep = value;
              });
            },
            onStepContinue: () {
              setState(() {
                if (initialStep < steps.length - 1) {
                  initialStep = initialStep + 1;
                } else {
                  // Lorsque l'utilisateur arrive à la dernière étape, il voit "Confirmer"
                  print("Données collectées: $medecinData");
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (initialStep > 0) {
                  initialStep = initialStep - 1;
                } else {
                  initialStep = 0;
                }
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: initialStep == steps.length - 1
                          ? () async {
                            
                              await inscrireMedecin();
                              print('voila $medecinData');
                              print("Médecin inscrit avec succès!");
                            }
                          : details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        initialStep == steps.length - 1
                            ? 'Confirmer'
                            : 'Continuer',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }

Future<void> inscrireMedecin() async {
  try {
    // Récupération des données
    String nom = medecinData['nom'] ?? '';
    String email = medecinData['email'] ?? '';
    String adresse = medecinData['adresse'] ?? '';
    String password = medecinData['password'] ?? '';
    
    // Ces deux lignes sont importantes!
    String dateOfNaiss = medecinData['dateOfNaiss'] ?? '';
    String sexe = medecinData['gender'] ?? ''; // Attention ici !
    
    String rpps = medecinData['rpps'] ?? '';
    String photo = medecinData['photo'] ?? '';
    String specialite = medecinData['specialite'] ?? '';
    List<Jourdisponibilite> jours = medecinData['doctorAvailability'] ?? [];

    // Pour le débogage, ajoutez ceci
    print("Données qui seront envoyées à Firestore:");
    print("dateOfNaiss: $dateOfNaiss");
    print("sexe: $sexe");
    
    // Appel de la fonction pour envoyer à Firestore
    await Auth().inscrireMedecin(
      nom,
      email,
      adresse,
      password,
      dateOfNaiss, 
      sexe,         
      rpps,
      photo,
      specialite,
      jours,
    );

    print("Médecin inscrit avec succès!");
  } catch (e) {
    print("Erreur lors de l'inscription du médecin: $e");
  }
}

}
