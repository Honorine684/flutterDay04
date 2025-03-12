import 'package:flutter/material.dart';

class CreneauxSelector extends StatefulWidget {
  final List<Map<String, dynamic>> creneaux;

  const CreneauxSelector({super.key, required this.creneaux});

  @override
  CreneauxSelectorState createState() => CreneauxSelectorState();
}

class CreneauxSelectorState extends State<CreneauxSelector> {
  String? selectedCreneau;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.creneaux.length,
      itemBuilder: (context, index) {
        final jour = widget.creneaux[index]["jour"];
        final heures = widget.creneaux[index]["heures"] as List<String>;

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2,
          child: ExpansionTile(
            title: Text(
              jour,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: heures.map((heure) {
                    final creneau = "$jour à $heure";
                    return ChoiceChip(
                      label: Text(heure),
                      selected: selectedCreneau == creneau,
                      selectedColor: Colors.blue[200],
                      onSelected: (selected) {
                        setState(() {
                          selectedCreneau = selected ? creneau : null;
                        });
                        print("Créneau sélectionné : $creneau");
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}