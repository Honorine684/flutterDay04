import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Firestoreservices {
  final CollectionReference specialite = FirebaseFirestore.instance.collection('specialite');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Récupérer les spécialités une seule fois
  Stream<QuerySnapshot> getSpecialite(){
    final specialiteStream = specialite.orderBy('timestamp', descending: true).snapshots();
    return  specialiteStream;
  }

  // Récupérer les médecins une seule fois
  Stream<QuerySnapshot> getDoctor(String specialite) {
    final doctorStream = users
        .where('role', isEqualTo: 'medecin')
        .where('specialite', isEqualTo: specialite)
        .snapshots();
    return doctorStream; 
  }

Stream<QuerySnapshot> getCreneauxForDoctor(String doctorId) {
  try {
    final creneauStream = FirebaseFirestore.instance
        .collection('users')
        .doc(doctorId)
        .collection('creneaux')
        .snapshots();
    return creneauStream;
  } catch (e) {
    print("Erreur lors de la récupération des créneaux: $e");
    rethrow; 
  }
}
}