import 'package:flutter/material.dart';
import 'package:mediclic/Component/selectorCreneaux.dart';
import 'package:mediclic/JsonModels/Doctor.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';
import 'package:mediclic/Services/Firebase/FirestoresServices.dart';

class Prisederendezvous extends StatefulWidget {
  final Doctor doctor;
  const Prisederendezvous({super.key, required this.doctor});

  @override
  State<Prisederendezvous> createState() {
    return PrisederendezvousState();
  }
}

class PrisederendezvousState extends State<Prisederendezvous> {
  final formKey = GlobalKey<FormState>();
  final praticien = TextEditingController();
  final specialite = TextEditingController();
  final date = TextEditingController();
  final raison = TextEditingController();
  Map<String, dynamic>? selectedCreneau; // Stocker l'ID et la valeur du créneau

  void showAlertAppointementAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Récapitulatif du rendez-vous"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Praticien: ${praticien.text}"),
              SizedBox(height: 10),
              Text("Spécialité: ${specialite.text}"),
              SizedBox(height: 10),
              Text("Date du rendez-vous: ${date.text}"),
              SizedBox(height: 10),
              Text("Motif de consultation: ${raison.text}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  void showAlertDialogConfirmAppointement(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: const Text(
            "En cliquant sur Confirmer, vous acceptez de partager votre dossier médical avec ce docteur.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Non"),
            ),
            TextButton(
              onPressed: () async {

                 if (selectedCreneau == null || selectedCreneau?['id'] == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez sélectionner un créneau horaire")),
    );
    return;
  }
                if (formKey.currentState!.validate()) {
                  final praticienValue = praticien.text;
                  final specialiteValue = specialite.text;
                  final dateValue = date.text;
                  final motifValue = raison.text;

                  print("Praticien: $praticienValue");
                  print("Spécialité: $specialiteValue");
                  print("Date: $dateValue");
                  print("Motif: $motifValue");

                  // Récupérer le nom de l'utilisateur connecté
                  final String? nomUser = await Auth().getCurrentUserName();
                  if (nomUser == null) {
                    print("Erreur : Utilisateur non connecté.");
                    return;
                  }

                  // Récupérer l'ID du créneau sélectionné
                  final String? creneauId = selectedCreneau?['id'];
                  if (creneauId == null) {
                    print("Erreur : Aucun créneau sélectionné.");
                    return;
                  }

                
                  await Firestoreservices().addRendezVous(
                    praticien.text,
                    specialite.text,
                    nomUser,
                    date.text,
                  
                    raison.text,
                  );

                  Navigator.pop(context); 
                  showAlertAppointementAdd(context); 
                }
              },
              child: Text("Confirmer"),
            ),
          ],
        );
      },
    );
  }

  @override
void initState() {
  praticien.text = widget.doctor.nom;
  specialite.text = widget.doctor.specialite;
  date.text = '';
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: largeurEcran * 0.88,
                height: 150,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Prise de Rendez-vous",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: largeurEcran * 0.65,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: TextButton(
                          onPressed: () {
                            showAlertDialogConfirmAppointement(context);
                          },
                          child: Text(
                            'Confirmer le rendez-vous',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Praticien",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: praticien,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    suffixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    labelText: "Praticien",
                    hintText: "Praticien",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Spécialité medicale",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: specialite,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    suffixIcon: const Icon(Icons.star),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    labelText: "Spécialité",
                    hintText: "Spécialité",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Date du rendez-vous",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: date, // Rétablir le contrôleur
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    suffixIcon: const Icon(Icons.golf_course),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    labelText: "Date du rendez-vous",
                    hintText: "Date du rendez-vous",
                  ),
                ),
              ),
              CreneauxSelector(
                creneaux: widget.doctor.creneaux,
                onCreneauSelected: (creneauId, creneauValue) {
                  setState(() {
                    selectedCreneau = {
                      'id': creneauId,
                      'value': creneauValue,
                    };
                    date.text = creneauValue; // Mettre à jour le champ de date
                  });
                  print("Créneau sélectionné : $creneauValue, ID: $creneauId");
                },
              ),
              Row(
                children: [
                  Text(
                    "Motif de la consultation",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: raison,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    suffixIcon: const Icon(Icons.sick),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    labelText: "Raison",
                    hintText: "Expliquez brièvement ce que vous ressentez",
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}