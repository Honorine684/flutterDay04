import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclinique/JsonModels/JourDisponibilite.dart';

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   User? get currentUser =>_firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createUserWithEmailAndPassword(
    String username, String email,String password,{String role = 'admin'})async {
      
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!= null){
        await firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'username':username,
            'email':email,
            'role':role,
            'timestamp':Timestamp.now()
          }
        );
      }
    }catch(e){
      print("Erreur lors de la creation de l'user $e");
    }
  }
// login
Future<void> SigninWithEmailAndPassword(String email,String password) async{
  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
} 
// logout
Future<void> logout()async{
  await _firebaseAuth.signOut();
}

Future<void> inscrireMedecin(
  String nom,
  String email,
  String adresse,
  String password,
  Timestamp dateNaissance,
  String sexe,
  String rpps,
  String specialiteId,
  String specialite,
  List<Jourdisponibilite> jours,
  {String role = 'medecin'}

)async{
  

  try{
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    String userId = userCredential.user!.uid;
         final WriteBatch batch = firestore.batch();
    
    DocumentReference userRef = firestore.collection('users').doc(userId);
    batch.set(userRef, {
      'nom': nom,
      'email': email,
      'adresse': adresse,
      'dateNaissance':dateNaissance,
      'sexe':sexe,
      'rpps':rpps,
      'specialiteId':specialiteId,
      'specialite':specialite,
      'role': 'medecin',
      'timestamp': Timestamp.now(),
    });
    
    //Ajouter les créneaux dans une sous-collection
    for (Jourdisponibilite jour in jours) {
      DocumentReference creneauRef = userRef.collection('creneaux').doc();
      batch.set(creneauRef, jour.toMap());
    }
    
    // Exécuter toutes les opérations Firestore
    await batch.commit();
    
    print('Compte medecin créé avec succès!');
  }catch(e){
    print("Erreur lors de la creation du medecin $e");
  }
}

Future<void> inscrireClinique(
    String username,String adresse, String email,String password,{String role = 'clinique'})async {
      
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!= null){
        await firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'username':username,
            'adresse' : adresse,
            'email':email,
            'role':role,
            'timestamp':Timestamp.now()
          }
        );
        print("Utilisateur creer avec succes");
      }
    }catch(e){
      print("Erreur lors de la creation de l'user $e");
    }
  }
}



