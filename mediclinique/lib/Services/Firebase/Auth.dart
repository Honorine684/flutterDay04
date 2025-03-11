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
  String dateOfNaiss,
  String gender, // Renommez ce paramètre pour correspondre à ce que vous utilisez
  String rpps,
  String photo,
  String specialite,
  List<Jourdisponibilite> jours,
  {String role = 'medecin'}
) async {
  try {
    // Créer un utilisateur Firebase
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    
    // Ajouter les informations de l'utilisateur - Utilisez les mêmes noms de champs partout
    await firestore.collection('users').doc(userCredential.user!.uid).set({
      'nom': nom,
      'email': email,
      'adresse': adresse,
      'dateOfNaiss': dateOfNaiss, // Gardez ce nom de champ cohérent
      'gender': gender,           // Gardez ce nom de champ cohérent
      'rpps': rpps,
      'photo': photo,
      'specialite': specialite,
      'role': role,
      'timestamp': Timestamp.now(),
    });

    print("Document principal créé avec dateOfNaiss: $dateOfNaiss et gender: $gender");
    
    // Le reste du code pour les créneaux...
    List<Jourdisponibilite> joursDisponibles = jours.where((jour) => jour.estDisponible).toList();
    
    for (Jourdisponibilite jour in joursDisponibles) {
      if (jour.estDisponible && jour.creneaux.isNotEmpty) {
        DocumentReference jourRef = firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .collection('creneaux')
            .doc(jour.day);
        
        await jourRef.set(jour.toMap());
        print('Créneaux ajoutés pour ${jour.day}');
      }
    }

    print('Compte médecin créé avec succès!');
  } catch (e) {
    print("Erreur lors de la création du médecin: $e");
    throw e;
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



