import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user() => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  Future<void> createUserWithEmailAndPassword(
    String username, String email,String password,{String role = 'admin'})async {
      
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!= null){
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(
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
}



