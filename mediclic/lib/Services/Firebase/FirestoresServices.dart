import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Firestoreservices {

final CollectionReference specialite = FirebaseFirestore.instance.collection('specialite');

Stream<QuerySnapshot> getSpecialite(){
  final produitStream = specialite.orderBy('timestamp',descending: true).snapshots();
  return produitStream;
}


}