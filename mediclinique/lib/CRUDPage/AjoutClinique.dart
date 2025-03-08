import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Ajoutclinique extends StatefulWidget {
  const Ajoutclinique({super.key});

  @override
  State<Ajoutclinique> createState() {
    return AjoutcliniqueState();
  }

}

class AjoutcliniqueState extends State<Ajoutclinique>{
List<String> specialites = [];
Future<void> loadSpecialite()async{
 try{
  final snapshot = await FirebaseFirestore.instance.collection('specialite').get();
  final listSpecialite = snapshot.docs.map((doc)=> doc['libelle'] as String).toList();
  setState(() {
    specialites = listSpecialite;
  });
 }catch(e){
  print("Erreur lors du chargement des specialites");
 }
}
@override
  void initState() {
    loadSpecialite();
    super.initState();
  }
  final formKey = GlobalKey<FormState>();
  final nom = TextEditingController();
  final adresse = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une clinique",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key :formKey,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                 
                    controller: nom,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "le nom est obligatoire";
                      }else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(nom.text)){
                        return "Le nom ne peut contenir que des lettres";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon:
                            const Icon(Icons.near_me),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        
                        labelText: "Nom",
                        hintText: "Nom clinique"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: adresse,
                    
                       validator: (value) {
                      if (value!.isEmpty) {
                        return "l'adresse est obligatoire";
                      }else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(adresse.text)){
                        return "L'adresse ne peut contenir que des caractères";
                      }
                      return null;
                    },
               
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon:
                            const Icon(Icons.local_activity),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Adrese",
                        hintText: "Adresse clinique"),
                  ),
                ),
                SizedBox(
                  width:largeurEcran*0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (formKey.currentState!.validate()) {
                       // Firestoreservices().addCategorie(codCat.text, libCat.text);
                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "Ajouter la clinique",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          )
        )
      ),
    );
  }
  
}