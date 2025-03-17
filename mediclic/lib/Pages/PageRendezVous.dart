import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({super.key});

  @override
  _RendezVousPageState createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> rendezVousList = [];

  @override
  void initState() {
    super.initState();
    fetchRendezVous();
  }

  Future<void> fetchRendezVous() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('rendezVous').get();

      setState(() {
        rendezVousList = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
      });

      print("📌 Nombre total de rendez-vous récupérés : ${rendezVousList.length}");
    } catch (e) {
      print("❌ Erreur lors de la récupération des rendez-vous : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("📅 Mes Rendez-vous"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: rendezVousList.isEmpty
          ? Center(
              child: Text(
                "Aucun rendez-vous trouvé",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: rendezVousList.length,
              itemBuilder: (context, index) {
                var rdv = rendezVousList[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: Icon(Icons.person, color: Colors.blueAccent, size: 40),
                    title: Text(
                      "${rdv['nomUser']}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text("🩺 Docteur : ${rdv['praticien']}"),
                        Text("📖 Spécialité : ${rdv['specialite']}"),
                        Text("📅 Date : ${rdv['date']}"),
                        Text("❓ Raison : ${rdv['raison']}"),
                      ],
                    ),
                    trailing: Icon(Icons.calendar_today, color: Colors.blueAccent),
                  ),
                );
              },
            ),
    );
  }
}