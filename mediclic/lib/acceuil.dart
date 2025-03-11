import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue[800],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Good morning",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Mosarraf",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text("Find your doctor...", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // ajout des boutons de catégorie pour un accès rapide aux services médicaux
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        categoryButton(Icons.person, "Doctors", Colors.blue),
                        categoryButton(Icons.local_pharmacy, "Pharmacy", Colors.grey),
                        categoryButton(Icons.local_hospital, "Hospital", Colors.grey),
                        categoryButton(Icons.apps, "More", Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // implémenter un PageView pour la section des conseils de santé
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Take care for your health",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text("Fill out your medical card right now"),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Care now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //  ajout d'un indicateur de pagination pour les conseils de santé
              // Cela ferait partie du PageView dans une implémentation réelle

              SizedBox(height: 20),
             
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Specialist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        specialistButton(Icons.medical_services, "Pathologist", Colors.blue),
                        specialistButton(Icons.face, "Dentist", Colors.grey),
                        specialistButton(Icons.favorite, "Cardiologist", Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
             
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Available doctors", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        doctorProfile(),
                        doctorProfile(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50), // Ajout d'espace en bas pour éviter un écrasement
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

 
  Widget categoryButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 30, color: color),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }

 
  Widget specialistButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }


  Widget doctorProfile() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        Text("Dr. Name"),
      ],
    );
  }
}