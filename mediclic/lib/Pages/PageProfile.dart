import 'package:flutter/material.dart';
import 'package:mediclic/Authentication/Login.dart';
import 'package:mediclic/Pages/AddInfo.dart';
import 'package:mediclic/Pages/DossierMedical.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
          Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(" "),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text("Honorine GABIAM"),
                        Text("N° compte: 038589"),
                      ],
                    ),])),
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Informations Personnelles"),
              trailing:
                  IconButton(onPressed: () {
                     Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddInfos()));
                  }, icon: Icon(Icons.navigate_next)),
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(Icons.edit_document),
              title: Text("Mon Dossier Médical "),
              trailing:
                  IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DossierMedical()));
                  }, icon: Icon(Icons.navigate_next)),
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Liste des Consultations"),
              trailing:
                  IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
            ),
            SizedBox(
              height: 25,
            ),
                ListTile(
              leading: Icon(Icons.logout),
              title: Text("Deconnexion",style: TextStyle(color: Colors.red),),
              trailing:
                  IconButton(onPressed: () {
                    Auth().logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false,
                  );
                  }, icon: Icon(Icons.navigate_next)),
            ),
           
          ],
        ),
          ));
    
  }
}