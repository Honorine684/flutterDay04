import 'package:flutter/material.dart';
import 'package:mediclinique/Component/Step2Widget/DatePicker.dart';
import 'package:mediclinique/Component/Step2Widget/genreChoice.dart';
import 'package:mediclinique/Component/Step2Widget/photo.dart';
import 'package:intl/intl.dart'; // Importez le package intl pour le formatage de la date

class Step2 extends StatefulWidget {
  const Step2({super.key, required this.onDataChanged});

  final void Function(Map<String, dynamic> data) onDataChanged; // Callback

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  DateTime? selectedDateObj; // Stockez l'objet DateTime
  String? selectedDate; // La date formatée en string
  String selectedGender = 'Femme';
  String? photoPath;

  // Fonction pour formater la date en string
  String formatDate(DateTime date) {
    // Format: YYYY-MM-DD (ISO 8601)
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Fonction pour envoyer les données au parent via le callback
  void sendDataToParent() {
    Map<String, dynamic> data = {
      'dateOfNaiss': selectedDate,
      'gender': selectedGender,
      'photo': photoPath,
    };

    widget.onDataChanged(data); // Appel du callback avec les données
  }
@override
  void initState() {
    sendDataToParent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date de naissance
        DatePicker(
          onDateChanged: (DateTime date) {
            setState(() {
              selectedDateObj = date;
              selectedDate = formatDate(date); // Convertir la date en string formaté
            });
            sendDataToParent(); // Envoie des données après sélection de la date
          },
        ),
        SizedBox(height: 20),
        // Sexe
        Genrechoice(
          selectedGender: selectedGender,
          onGenderChanged: (String gender) {
            setState(() {
              selectedGender = gender;
            });
            sendDataToParent(); // Envoie des données après modification du genre
          },
        ),
        SizedBox(height: 20),
        // Photo
        Photo(
          onPhotoChanged: (String? path) {
            setState(() {
              photoPath = path;
            });
            sendDataToParent(); // Envoie des données après modification de la photo
          },
        ),
      ],
    );
  }
}