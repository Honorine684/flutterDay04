import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservices {
  final CollectionReference specialite = FirebaseFirestore.instance.collection('specialite');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference rendezVous = FirebaseFirestore.instance.collection('rendezVous');

  // Récupérer les spécialités
  Stream<QuerySnapshot> getSpecialite() {
    try {
      final specialiteStream = specialite.orderBy('timestamp', descending: true).snapshots();
      specialiteStream.listen((snapshot) {
        print("Spécialités récupérées: ${snapshot.docs.length}");
      });
      return specialiteStream;
    } catch (e) {
      print("Erreur lors de la récupération des spécialités: $e");
      rethrow;
    }
  }

  // Récupérer les médecins par spécialité
  Stream<QuerySnapshot> getDoctor(String specialite) {
    try {
      final doctorStream = users
          .where('role', isEqualTo: 'medecin')
          .where('specialite', isEqualTo: specialite)
          .snapshots();
      doctorStream.listen((snapshot) {
        print("Médecins récupérés: ${snapshot.docs.length}");
      });
      return doctorStream;
    } catch (e) {
      print("Erreur lors de la récupération des médecins: $e");
      rethrow;
    }
  }

  // Récupérer les créneaux d'un médecin
  Stream<QuerySnapshot> getCreneauxForDoctor(String doctorId) {
    try {
      final creneauStream = FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .collection('creneaux')
          .snapshots();
      creneauStream.listen((snapshot) {
        print("Créneaux récupérés pour le médecin $doctorId: ${snapshot.docs.length}");
      });
      return creneauStream;
    } catch (e) {
      print("Erreur lors de la récupération des créneaux: $e");
      rethrow;
    }
  }
Future<void> addRendezVous(
  String praticien,
  String specialite,
  String nomUser,
  String date,
  String raison,
) async {
  // Vérifier que les paramètres requis ne sont pas vides
  if (praticien.isEmpty) {
    throw Exception("Le nom du praticien ne peut pas être vide");
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Référence au document du rendez-vous
  final DocumentReference rendezVousRef = firestore.collection('rendezVous').doc();

  // Ajouter le rendez-vous
  try {
    await rendezVousRef.set({
      'praticien': praticien,
      'specialite': specialite,
      'nomUser': nomUser,
      'date': date,
      'raison': raison,
      'timestamp': Timestamp.now(),
    });

    print("Rendez-vous ajouté avec succès.");
  } catch (e) {
    print("Erreur lors de l'ajout du rendez-vous: $e");
    rethrow;
  }
}
}