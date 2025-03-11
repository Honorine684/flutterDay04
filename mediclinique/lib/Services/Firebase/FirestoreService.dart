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
  
}