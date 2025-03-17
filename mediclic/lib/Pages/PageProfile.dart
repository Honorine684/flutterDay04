import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclic/Authentication/Login.dart';
import 'package:mediclic/Pages/DossierMedical.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';

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
         
          ),
      body: _user == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Affiche un chargement si l'utilisateur n'est pas encore récupéré
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
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
                          ListTile(
                            leading: Icon(Icons.edit_document),
                            title: Text("Mon Dossier Médical "),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                          builder: (context) =>
                                              const DossierMedical())));
                                },
                                icon: Icon(Icons.navigate_next)),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text("Liste des Consultations"),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.navigate_next)),
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
                        Auth().logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation:
                            5, // Légère ombre pour un effet de profondeur
                      ),
                      child: Text("Se déconnecter",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
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
