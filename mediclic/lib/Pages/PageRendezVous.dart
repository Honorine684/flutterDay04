import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({super.key});

  @override
  _RendezVousPageState createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> rendezVousList = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRendezVous();
  }

  Future<void> fetchRendezVous() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      // Récupérer l'utilisateur actuellement connecté
      User? currentUser = _auth.currentUser;
      
      if (currentUser == null) {
        setState(() {
          _errorMessage = "Aucun utilisateur connecté";
          _isLoading = false;
        });
        return;
      }
      
      // Récupérer les rendez-vous où l'userId correspond à l'ID de l'utilisateur connecté
      QuerySnapshot querySnapshot = await _firestore
          .collection('rendezVous')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      setState(() {
        rendezVousList = querySnapshot.docs.map((doc) {
          // Inclure l'ID du document dans les données
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();
        _isLoading = false;
      });

      print("📌 Nombre de rendez-vous récupérés pour l'utilisateur ${currentUser.uid}: ${rendezVousList.length}");
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur lors de la récupération des rendez-vous";
        _isLoading = false;
      });
      print("❌ Erreur lors de la récupération des rendez-vous : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📅 Mes Rendez-vous"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                )
              : rendezVousList.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun rendez-vous trouvé",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: rendezVousList.length,
                      itemBuilder: (context, index) {
                        var rdv = rendezVousList[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            leading: const Icon(Icons.person, color: Colors.blueAccent, size: 40),
                            title: Text(
                              "${rdv['nomUser']}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text("🩺 Docteur : ${rdv['praticien']}"),
                                Text("📖 Spécialité : ${rdv['specialite']}"),
                                Text("📅 Date : ${rdv['date']}"),
                                Text("❓ Raison : ${rdv['raison']}"),
                              ],
                            ),
                            trailing: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                          ),
                        );
                      },
                    ),
    );
  }
}