import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mediclinique/CRUDPage/AjoutClinique.dart';
import 'package:mediclinique/CRUDPage/AjoutSpecialite.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
  
}
class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
   return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      //backgroundColor: Colors.deepPurple,
    
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Accès rapide",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: hauteurEcran*0.02,),
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 150,
                child: Card(
                elevation: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF6CFF3).withOpacity(0.2)
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajoutspecialite()));
                        }, 
                        icon: Icon(Icons.add,color: Color(0xffF6CFF3),)),
                    ),
                    Text("Ajouter spécialité",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                
            ],
          )
          )),
          SizedBox(
                height: 120,
                width: 150,
                child: Card(
                elevation: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade100
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajoutclinique()));
                        }, 
                        icon: Icon(Icons.add,color: Colors.blue,)),
                    ),
                    Text("Ajouter clinique",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              )
          ],
          
      ),
   ] ),

   ));
  }
  
}