import 'package:flutter/material.dart';

class Genrechoice extends StatefulWidget {
  const Genrechoice({super.key});

  @override
  State<Genrechoice> createState() {
    return GenrechoiceState();
  }
}

List<String> sexe = ['Femme', 'Homme'];

class GenrechoiceState extends State<Genrechoice> {
  String currentOption = sexe[0];

  @override
  Widget build(BuildContext context) {
    return

        // Utilisation d'Expanded pour s'assurer que les éléments dans le Row prennent toute la largeur disponible
        Row(
      children: [
        Text(
          "Votre sexe",
          style: TextStyle(fontSize: 14),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              "Femme",
              style: TextStyle(fontSize: 10),
            ),
            leading: Radio<String>(
              value: sexe[0],
              groupValue: currentOption,
              onChanged: (String? value) {
                setState(() {
                  currentOption = value!;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              "Homme",
              style: TextStyle(fontSize: 10),
            ),
            leading: Radio<String>(
              value: sexe[1],
              groupValue: currentOption,
              onChanged: (String? value) {
                setState(() {
                  currentOption = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
