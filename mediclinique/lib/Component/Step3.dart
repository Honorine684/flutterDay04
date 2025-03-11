import 'package:flutter/material.dart';
import 'package:mediclinique/Component/step3Widget/validatorRpps.dart';
import 'package:mediclinique/JsonModels/Specialite.dart';
import 'package:mediclinique/Services/Firebase/FirestoreService.dart';

class Step3 extends StatefulWidget {
  const Step3({super.key});

  @override
  State<Step3> createState() {
    return Step3State();
  }
}

class Step3State extends State<Step3> {
  List<Specialite> specialites = [];
  Specialite? selectedSpecialite;
  void loadSpecialite() {
    print("Démarrage du chargement des specialites...");
    Firestoreservice().getSpecialite().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Specialite> specialiteList = [];

      for (var doc in snapshot.docs) {
        try {
          String libelle = doc.get('libelle');
          String id = doc.id;
          specialiteList.add(Specialite(id: id, libelle: libelle));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        specialites = specialiteList;
        if (specialiteList.isNotEmpty && selectedSpecialite == null) {
          selectedSpecialite = specialiteList[0];
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des specialites: $error");
    });
  }

  @override
  void initState() {
    loadSpecialite();
    super.initState();
  }

  final controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RPPS
        RPPSFormField(),
        /* 
      10101010101
29900010208
40123456782
11122233349
80010020030
      */
        // specialite medicale
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.teal.shade700,
                width: 2.0,
              ),
            ),
          ),
          child: DropdownButtonFormField<Specialite>(
            decoration: const InputDecoration(
              icon: Icon(Icons.store),
              border: InputBorder.none,
              hintText: "Sélectionnez une specialite",
            ),
            value: selectedSpecialite,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: specialites.map((categorie) {
              return DropdownMenuItem<Specialite>(
                value: categorie,
                child: Text(categorie.libelle),
              );
            }).toList(),
            onChanged: (Specialite? newValue) async {
              setState(() {
                selectedSpecialite = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
