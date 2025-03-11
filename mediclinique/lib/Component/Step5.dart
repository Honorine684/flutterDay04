import 'package:flutter/material.dart';
import 'package:mediclinique/JsonModels/JourDisponibilite.dart';
import 'package:mediclinique/Component/horairewidget/SelectorAvailable.dart';

class Step5 extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  const Step5({super.key, required this.onDataChanged});

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
            setState(() {
              doctorAvailability = availability;
            });

            widget.onDataChanged({
              'doctorAvailability': doctorAvailability,
            });
          },
        ),
      ],
    );
  }
}
