import 'package:flutter/material.dart';

class Prisederendezvous extends StatefulWidget{
  const Prisederendezvous({super.key});

  @override
  State<Prisederendezvous> createState() {
   return PrisederendezvousState();
  }

}
class PrisederendezvousState extends State<Prisederendezvous>{
  @override
  Widget build(BuildContext context) {
  final largeurEcran = MediaQuery.of(context).size.width  ;
  return Scaffold(
    appBar: AppBar(),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          SizedBox(
            width: largeurEcran*0.88,
            height: 150,
            child:          Card(
            color: Colors.white,
            elevation: 5,
            child: 
            Column(
              children: [
                SizedBox(height: 20,),
                Text("Prise de Rendez-vous",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Container(
                  width: largeurEcran*0.65,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: (){}, 
                    child: Text('Confirmer le rendez-vous',style: TextStyle(fontSize: 14,color: Colors.white),)),
                )
              ],
            ),
          ) ,
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text("Praticien",style: TextStyle(fontSize: 13),),
            ],
          ),                
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon:
                              const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Praticien",
                          hintText: "Praticien"),
                    ),
                  ),
                            SizedBox(height: 10,),
          Row(
            children: [
              Text("Spécialité medicale",style: TextStyle(fontSize: 13),),
            ],
          ),                
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon:
                              const Icon(Icons.star),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Spécialité",
                          hintText: "Spécialité"),
                    ),
                  ),
                                              SizedBox(height: 10,),
          Row(
            children: [
              Text("Date du rendez-vous",style: TextStyle(fontSize: 13),),
            ],
          ),                
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          suffixIcon:
                              const Icon(Icons.golf_course),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Date du rendez-vous",
                          hintText: "Date du rendez-vous"),
                    ),
                  ),
                  
        ],
      ),
    )
);
  }
  
}