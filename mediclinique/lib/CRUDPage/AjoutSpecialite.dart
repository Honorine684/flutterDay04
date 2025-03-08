import 'package:flutter/material.dart';
import 'package:mediclinique/Services/Firebase/FirestoreService.dart';


class Ajoutspecialite extends StatefulWidget {
  const Ajoutspecialite({super.key});

  @override
  State<Ajoutspecialite> createState() {
    return AjoutspecialiteState();
  }

}

class AjoutspecialiteState extends State<Ajoutspecialite>{
  
  final formKey = GlobalKey<FormState>();
  final code = TextEditingController();
  final libelle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une specialite",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                    controller: code,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "le code est obligatoire";
                      }else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(code.text)){
                        return "Le code ne peut contenir que des lettres";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        suffixIcon:
                            const Icon(Icons.code),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: "Code",
                        hintText: "Code spécialité"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: libelle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "le libelle est obligatoire";
                      }else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(libelle.text)){
                        return "Le libelle ne peut contenir que des lettres";
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
                        labelText: "Libellé",
                        hintText: "Libelle specialité"),
                  ),
                ),
                SizedBox(
                  width:largeurEcran*0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (formKey.currentState!.validate()) {
                       Firestoreservice().addSpecialite(code.text, libelle.text);
                        
                      }
                      code.clear();
                      libelle.clear();
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
                      "Ajouter la specialite",
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