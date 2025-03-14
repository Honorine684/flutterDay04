import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservice {
  // collection specialite
  final CollectionReference specialite = FirebaseFirestore.instance.collection("specialite");
  Future<DocumentReference<Object?>> addSpecialite(String code,String libelle) async{
    return specialite.add({
      'code':code,
      'libelle':libelle,
      'timestamp':Timestamp.now()
    });
  }
Stream<QuerySnapshot> getSpecialite(){
  final specialiteStream = specialite.orderBy('timestamp',descending: true).snapshots();
  return specialiteStream;
}
final CollectionReference rendezVous = FirebaseFirestore.instance.collection("rendezVous");


  // Méthode pour récupérer les rendez-vous de l'utilisateur connecté
  Stream<QuerySnapshot> getRendezVous(String doctorId) {
    return rendezVous
        .where('doctor_id', isEqualTo: doctorId)
        .snapshots();
  }
  
}