import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/SignupMedecin.dart';
import 'package:mediclinique/Pages/PageProfileClinique.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final hauteurEcran = MediaQuery.of(context).size.height;
   final largeurEcran = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                "Mediclinique",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Icon(
                Icons.health_and_safety,
                color: Colors.blue,
              ),
              
            ],

          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20,left: 20),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                    child:
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PageProfile()));
                        }, icon: Icon(Icons.person)),
                  )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tableau de bord",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
Row(
                children: [
                  SizedBox(
                      height: 130,
                      width: 160,
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
                                    color: Color(0xffF6CFF3).withOpacity(0.2)),
                                child: IconButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajoutspecialite()));
                                    },
                                    icon: Icon(
                                      Icons.person,
                                      color: Color(0xffF6CFF3),
                                    )),
                              ),
                              Text(
                                "26 patients",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 130,
                    width: 160,
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
                                color: Colors.blue.shade100),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signupmedecin()));
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                )),
                          ),
                          Text(
                            "23 rendez-vous",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Vos rendez-vous",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: largeurEcran*0.88,
                    height: hauteurEcran*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade100
                    ),
                     child: SizedBox(
                      height: hauteurEcran*0.45,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                         SizedBox(height: 20,),
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            width: largeurEcran*0.6,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Text("9h30",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                SizedBox(width: 10,),
                                Text("HOnorine,abdoul",style: TextStyle(fontSize: 14),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}