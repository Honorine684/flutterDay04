import 'package:flutter/material.dart';

class Step4 extends StatefulWidget{
  const Step4({super.key});

  @override
  State<Step4> createState() {
   return Step4State();
  }

}
class Step4State extends State<Step4>{
  @override
  Widget build(BuildContext context) {
   return   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Confirmation votre ajout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                   /*   Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Récapitulatif des informations', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Text('Nom: ${_nomController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Adresse: ${_adresseController.text}'),
              Text('RPPS: ${_rppsController.text}'),
              Text('Date de naissance: ${DateFormat('dd/MM/yyyy').format(_dateNaissance)}'),
              Text('Sexe: $_sexe'),
              Text('Clinique: $_clinique'),
              SizedBox(height: 10),
              Text('Disponibilités:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._joursDisponibles.map((jour) {
                return Text('${_jourToString(jour.jour)}: ${_formatHeure(jour.heureDebut)} - ${_formatHeure(jour.heureFin)}');
              }).toList(),
            ],
          ),),*/
                      const SizedBox(height: 20),
                      const Text(
                        "En cliquant sur Continuer, vous acceptez nos conditions d'utilisation et notre politique de confidentialité.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),)]);

    
     
  


   
  }
  
}