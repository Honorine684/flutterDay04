import 'package:flutter/material.dart';
import 'package:mediclinique/Pages/Consultation.dart';
import 'package:mediclinique/Pages/DossierMedical.dart'; 

class ChoixPage extends StatelessWidget {
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;

  const ChoixPage({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choisissez une option",style: TextStyle(fontSize: 15,),),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjoutConsultation(
                      patientId: patientId,
                      patientName: patientName,
                      doctorId: doctorId,
                      doctorName: doctorName,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Nouvelle Consultation'),
            ),
            const SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DossierMedical(
                      patientId: patientId,
                      patientName: patientName,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Dossier Médical'),
            ),
          ],
        ),
      ),
    );
  }
}