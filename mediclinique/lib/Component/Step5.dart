import 'package:flutter/material.dart';
import 'package:mediclinique/JsonModels/JourDisponibilite.dart';
import 'package:mediclinique/Component/horairewidget/SelectorAvailable.dart';

class Step5 extends StatefulWidget {
  const Step5({super.key});

  @override
  State<Step5> createState() {
    return Step3State();
  }
}

class Step3State extends State<Step5> {
List<Jourdisponibilite> doctorAvailability = []; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      // horaire de disponibilite
        Selectoravailable(
                onDaychanged: (availability) {
                  doctorAvailability = availability;
                },
              ),
      ],
    );


  }
}
/* 
    specialites medicales
    etablissements d'exercics
    horaires de disponibilite
    
    */
