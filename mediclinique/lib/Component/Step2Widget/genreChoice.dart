import 'package:flutter/material.dart';

class Genrechoice extends StatefulWidget {
  const Genrechoice({super.key, required this.selectedGender, required this.onGenderChanged});

  final String selectedGender;
  final void Function(String gender) onGenderChanged; // Callback

  @override
  State<Genrechoice> createState() => GenrechoiceState();
}

class GenrechoiceState extends State<Genrechoice> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Votre sexe", style: TextStyle(fontSize: 14)),
        Expanded(
          child: ListTile(
            title: Text("Femme", style: TextStyle(fontSize: 10)),
            leading: Radio<String>(
              value: 'Femme',
              groupValue: widget.selectedGender,
              onChanged: (String? value) {
                setState(() {
                  widget.onGenderChanged(value!); // Envoie du genre sélectionné au parent
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text("Homme", style: TextStyle(fontSize: 10)),
            leading: Radio<String>(
              value: 'Homme',
              groupValue: widget.selectedGender,
              onChanged: (String? value) {
                setState(() {
                  widget.onGenderChanged(value!); // Envoie du genre sélectionné au parent
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
