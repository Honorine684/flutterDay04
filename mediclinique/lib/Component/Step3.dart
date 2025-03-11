import 'package:flutter/material.dart';
import 'package:mediclinique/Component/step3Widget/validatorRpps.dart';
import 'package:mediclinique/JsonModels/Specialite.dart';
import 'package:mediclinique/Services/Firebase/FirestoreService.dart';

class Step3 extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  const Step3({
    super.key,
    required this.onDataChanged,
  });

  @override
  State<Step3> createState() {
    return Step3State();
  }
}

class Step3State extends State<Step3> {
  void updateData() {
    widget.onDataChanged({
      'rpps': controller.text, // Envoi de la valeur RPPS
      'specialite':
          selectedSpecialite?.libelle, // Envoi de la spécialité sélectionnée
    });
  }

  @override
  void dispose() {
    controller.removeListener(updateData);
    super.dispose();
  }

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
void onSpecialiteChanged(Specialite? newSpecialite) {
  setState(() {
    selectedSpecialite = newSpecialite;
  });
  updateData(); // Mettre à jour les données immédiatement après la sélection
}

  @override
  void initState() {
    loadSpecialite();
    controller.addListener(updateData);
    super.initState();
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RPPS
        RPPSFormField(controller: controller),
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
          onChanged: (Specialite? newValue) {
            setState(() {
              selectedSpecialite = newValue;
            });
            updateData(); // Mettre à jour les données immédiatement après la sélection
          },
        ),
      ),
    ],
  );
}
}