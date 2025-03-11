import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final TextEditingController _rechercheController = TextEditingController();
  final PageController _pageController = PageController();
  int _indexActuel = 0;

  List<Map<String, String>> conseilsSante = [
    {
      "titre": "Restez hydraté",
      "description": "Buvez au moins 8 verres d'eau par jour.",
      "image": "assets/images/hydration.png"
    },
    {
      "titre": "Faites de l'exercice",
      "description": "Essayez de faire 30 minutes d'exercice quotidiennement.",
      "image": "assets/images/exercise.png"
    },
    {
      "titre": "Mangez sainement",
      "description": "Ajoutez des fruits et légumes à votre alimentation.",
      "image": "assets/images/healthy_food.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // En-tête
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue[800],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("Bonjour", style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text("Abdou", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    // Barre de recherche
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _rechercheController,
                        decoration: InputDecoration(
                          hintText: "Rechercher un médecin...",
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Boutons de catégorie cliquables
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boutonCategorie(Icons.person, "Médecins", () => print("Médecins cliqué")),
                        boutonCategorie(Icons.local_pharmacy, "Pharmacie", () => print("Pharmacie cliquée")),
                        boutonCategorie(Icons.local_hospital, "Hôpital", () => print("Hôpital cliqué")),
                        boutonCategorie(Icons.apps, "Plus", () => print("Plus cliqué")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // PageView avec conseils de santé
              Container(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: conseilsSante.length,
                  onPageChanged: (index) {
                    setState(() {
                      _indexActuel = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return carteConseil(
                      conseilsSante[index]["titre"]!,
                      conseilsSante[index]["description"]!,
                      conseilsSante[index]["image"]!,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),

              // Indicateur de pagination
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  conseilsSante.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: _indexActuel == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _indexActuel == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Section spécialistes
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spécialistes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boutonSpecialiste(Icons.medical_services, "Pathologiste", () => print("Pathologiste cliqué")),
                        boutonSpecialiste(Icons.face, "Dentiste", () => print("Dentiste cliqué")),
                        boutonSpecialiste(Icons.favorite, "Cardiologue", () => print("Cardiologue cliqué")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Liste des médecins disponibles avec images
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Médecins disponibles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        profilMedecin("Dr. Alice", "assets/images/doc1.png", () => print("Dr. Alice cliquée")),
                        profilMedecin("Dr. Bruno", "assets/images/doc2.png", () => print("Dr. Bruno cliqué")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Carte pour un conseil de santé
  Widget carteConseil(String titre, String description, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 80, height: 80),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titre, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Boutons cliquables
  Widget boutonCategorie(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          Text(label),
        ],
      ),
    );
  }

  Widget boutonSpecialiste(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    );
  }

  Widget profilMedecin(String nom, String imagePath, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        SizedBox(height: 5),
        Text(nom),
      ],
    );
  }
}