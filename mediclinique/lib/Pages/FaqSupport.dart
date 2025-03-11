import 'package:flutter/material.dart';



class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<FAQItem> faqList = [
    FAQItem('Comment m\'inscrire à l\'application ?', 'Pour vous inscrire, ouvrez l\'application, cliquez sur "S\'inscrire", entrez vos informations, et suivez les instructions.'),
    FAQItem('Comment réinitialiser mon mot de passe ?', 'Cliquez sur "Mot de passe oublié ?", entrez votre e-mail et suivez les instructions reçues.'),
    FAQItem('Comment connecter mon appareil de suivi de santé ?', 'Accédez aux "Paramètres", sélectionnez "Appareils" et suivez les instructions pour connecter votre appareil via Bluetooth ou Wi-Fi.'),
    FAQItem('Comment saisir mes données manuellement ?', 'Allez dans la section "Suivi de santé", sélectionnez l\'indicateur, puis entrez vos données manuellement.'),
    FAQItem('Est-ce que mes données sont sécurisées ?', 'Oui, nous utilisons un chiffrement de bout en bout et respectons les normes de confidentialité comme le RGPD.'),
    FAQItem('Comment contacter le support ?', 'Vous pouvez nous contacter par e-mail, chat en direct, ou téléphone via la section "Support" dans l\'application.'),
    FAQItem('L\'application est-elle compatible avec tous les appareils ?', 'L\'application est compatible avec Android 5.0+ et iOS 12.0+ ou supérieur.'),
    FAQItem('Comment puis-je supprimer mon compte ?', 'Allez dans "Paramètres" > "Mon compte", puis sélectionnez "Supprimer mon compte" et suivez les instructions.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ / Support'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: faqList.map((faqItem) {
          return FAQTile(faqItem: faqItem);
        }).toList(),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem(this.question, this.answer, {this.isExpanded = false});
}

class FAQTile extends StatelessWidget {
  final FAQItem faqItem;

  FAQTile({required this.faqItem});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        faqItem.question,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: faqItem.isExpanded,
      onExpansionChanged: (bool expanded) {
        faqItem.isExpanded = expanded;
      },
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(faqItem.answer),
        ),
      ],
    );
  }
}
