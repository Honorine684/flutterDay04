import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Auth {
  //currentUser est une propriété native pour récuperer l'user connecté
  // alors que userCedential est une classe  utiliser pour stocker les infos de l'user immediatement apres login
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // RECUperer l'user connecter
  User? get currentUser =>_firebaseAuth.currentUser;
  Stream<User?> get authStateChanges =>_firebaseAuth.authStateChanges();
  //fonction pour stocker les données utilisateur
Future<void> createUserWithEmailAndPassword( {
  required String name,
  required String email, 
  required String password,
  String? photo,
  String? nomAyantDroit,
  String? contactAyantDroit,
  String role = 'patient'
}) async {
  try {
    // Créer l'utilisateur dans Authentication
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    
    // Ajouter l'utilisateur à Firestore avec toutes les informations
    if (userCredential.user != null) { // si l'user est connecter ajoute ces elements a la bdd
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'photo':photo,
        'nomAyantDroit':nomAyantDroit,
        'contactAyantDroit':contactAyantDroit,
        'role': role,
        'timestamp': Timestamp.now(), 
        
      });
    }
  } catch (e) {
    
    print("Erreur lors de la création de l'utilisateur: $e");
    throw e; 
  }
}
  //LOGIN email and password
 Future<void> loginWithEmailAndPassword(String email, String password) async {
 
    
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
    

     

}
  //logout
  Future<void> logout()async{
    await _firebaseAuth.signOut();
  }
  
}