import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  User? _user;
  String name = '';
  String nomAyantDroit = '';
  String email = '';
  String contactAyantDroit = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Récupérer les informations de l'utilisateur depuis Firestore
  Future<void> _getUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'] ?? 'Nom non défini';
            nomAyantDroit = userDoc['nomAyantDroit'] ?? 'Non défini';
            email = userDoc['email'] ?? 'Email non défini';
            contactAyantDroit = userDoc['contactAyantDroit'] ?? 'Non défini';
          });
        }
      } catch (e) {
        print('Erreur lors de la récupération des données: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil de l'utilisateur", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0, // Supprime l'ombre de l'AppBar
      ),
      body: _user == null
          ? Center(child: CircularProgressIndicator()) // Affiche un chargement si l'utilisateur n'est pas encore récupéré
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre de la page
                  Text(
                    "Mon Profil",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 30),

                  // Carte avec les informations de l'utilisateur
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Nom
                          InfoTile(
                            title: "Nom",
                            value: name,
                          ),
                          Divider(),
                          // Nom ayant droit
                          InfoTile(
                            title: "Nom Ayant Droit",
                            value: nomAyantDroit,
                          ),
                          Divider(),
                          // Email
                          InfoTile(
                            title: "Email",
                            value: email,
                          ),
                          Divider(),
                          // Contact ayant droit
                          InfoTile(
                            title: "Contact Ayant Droit",
                            value: contactAyantDroit,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Bouton de déconnexion
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Log out action
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("Se déconnecter", style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5, // Légère ombre pour un effet de profondeur
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// Widget pour afficher chaque information utilisateur
class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.blue),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}