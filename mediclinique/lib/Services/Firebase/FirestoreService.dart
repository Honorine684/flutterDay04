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
// ajouter consultation
final CollectionReference consultation = FirebaseFirestore.instance.collection("consultation");
  Future<DocumentReference<Object?>> addConsultation(String patientId,String patientName,String date,
  String doctorId ,String doctorName,String antecedent,String chronique,
  String chirurgicaux,String allergie,String traitementEnCours, String temperature,
  String siat,String dys,String frequanceCardiaque,String poids,String taille,String examenGeneral,
  String examenCardio,String examenRes,String examenDigestif,String examenNeuro,String examenArti,String otherExams,
  String diagnostic,String traitement,String note
   ) async{
    return consultation.add({
      'patientId':patientId,
      'patientName':patientName,
      'date':date,
      'doctorId':doctorId,
      'doctorName':doctorName,
      'antecedent':antecedent,
      'chronique':chronique,
      'chirurgicaux':chirurgicaux,
      'allergie':allergie,
      'traitementEnCours':traitementEnCours,
      'temperature':temperature,
      'siat':siat,
      'dys':dys,
      'frequanceCardiaque':frequanceCardiaque,
      'poids':poids,
      'taille':taille,
      'examenGeneral':examenGeneral,
      'examenCardio':examenCardio,
      'examenRespiratoire':examenRes,
      'examenDigestif':examenDigestif,
      'examenNeuro':examenNeuro,
      'examenArti':examenArti,
      'autresExamen':otherExams,
      'diagnostic':diagnostic,
      'traitement':traitement,
      'note':note

    });
  } 
}