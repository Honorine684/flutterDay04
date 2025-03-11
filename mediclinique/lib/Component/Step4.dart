import 'package:flutter/material.dart';

class Step4 extends StatefulWidget {
  const Step4({super.key});

  @override
  State<Step4> createState() {
    return Step4State();
  }
}

class Step4State extends State<Step4> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Confirmation votre ajout",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        "En cliquant sur Continuer, vous acceptez nos conditions d'utilisation et notre politique de confidentialité.",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      )
    ]);
  }
}
