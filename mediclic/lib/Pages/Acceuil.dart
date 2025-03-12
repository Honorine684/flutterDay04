import 'package:flutter/material.dart';
import 'package:mediclic/JsonModels/Doctor.dart';
import 'package:mediclic/JsonModels/Specialite.dart';
import 'package:mediclic/Pages/PageDetailsDoctor.dart';
import 'package:mediclic/Services/Firebase/FirestoresServices.dart';
import 'package:mediclic/cardio.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  AccueilState createState() => AccueilState();
}

final List<Map<String, String>> discover = [
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
  {
    "image": "assets/image/cli.jpeg",
    "texte": "Clinique Odessa",
  },
];

class AccueilState extends State<Accueil> {
  final TextEditingController _rechercheController = TextEditingController();
  final PageController pageController = PageController();
  int indexActuel = 0;
  int indexSelectionne = 0;
  List<Specialite> specialites = [];
  String? selectedSpecialite;
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    loadSpecialite();
  }

void loadDoctorsBySpecialite(String specialite) {
  print("Chargement des médecins pour la spécialité: $specialite");
  Firestoreservices().getDoctor(specialite).listen((snapshot) {
    List<Doctor> doctorList = [];
    
    // Compteur pour savoir quand tous les médecins sont chargés
    int doctorsToProcess = snapshot.docs.length;
    int doctorsProcessed = 0;
    
    if (doctorsToProcess == 0) {
      setState(() {
        doctors = []; // Aucun médecin trouvé
        print("Aucun médecin trouvé pour cette spécialité");
      });
      return;
    }
    
    for (var doc in snapshot.docs) {
      try {
        // Extraire les données de base du médecin
        Map<String, dynamic> doctorData = doc.data() as Map<String, dynamic>;
        
        // Récupérer les créneaux du médecin
        Firestoreservices().getCreneauxForDoctor(doc.id).listen((creneauxSnapshot) {
          List<Map<String, dynamic>> creneauxList = [];
          
          // Convertir les créneaux en Map
          for (var creneauDoc in creneauxSnapshot.docs) {
            creneauxList.add(creneauDoc.data() as Map<String, dynamic>);
          }
          
          // Créer l'objet Doctor avec toutes les données
          Doctor doctor = Doctor(
            id: doc.id,
            nom: doctorData['nom'] ?? 'Sans nom',
            genre: doctorData['genre'] ?? 'Non spécifié',
            photo: doctorData['photo'] ?? '',
            specialite: doctorData['specialite'] ?? specialite,
            creneaux: creneauxList
          );
          
          doctorList.add(doctor);
          doctorsProcessed++;
          
          // Mettre à jour l'état quand tous les médecins sont chargés
          if (doctorsProcessed == doctorsToProcess) {
            setState(() {
              doctors = doctorList;
              print("Médecins chargés: ${doctorList.length}");
            });
          }
        }, onError: (error) {
          print("Erreur lors du chargement des créneaux pour ${doc.id}: $error");
          doctorsProcessed++;
          
          // Même en cas d'erreur, on vérifie si tous les médecins ont été traités
          if (doctorsProcessed == doctorsToProcess) {
            setState(() {
              doctors = doctorList;
              print("Médecins chargés: ${doctorList.length}");
            });
          }
        });
      } catch (e) {
        print("Erreur sur un document médecin: $e");
        doctorsProcessed++;
      }
    }
  }, onError: (error) {
    print("Erreur lors du chargement des médecins: $error");
  });
}

  void loadSpecialite() {
    print("Démarrage du chargement des spécialités...");
    Firestoreservices().getSpecialite().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Specialite> specialiteList = [];

      for (var doc in snapshot.docs) {
        try {
          String id = doc.id;
          String libelle = doc.get('libelle');
          specialiteList.add(Specialite(id: id, libelle: libelle));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        specialites = specialiteList;
        print("Spécialités chargées: ${specialiteList.length}");
      });
    }, onError: (error) {
      print("Erreur lors du chargement des spécialités: $error");
    });
  }

  List<Map<String, String>> conseilsSante = [
    {
      "titre": "Restez hydraté",
      "description": "Buvez au moins 8 verres d'eau par jour.",
      "image": "assets/image/exercice.jpg"
    },
    {
      "titre": "Faites de l'exercice",
      "description": "Essayez de faire 30 minutes d'exercice quotidiennement.",
      "image": "assets/image/exercice.jpg"
    },
    {
      "titre": "Mangez sainement",
      "description": "Ajoutez des fruits et légumes à votre alimentation.",
      "image": "assets/image/exercice.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // En-tête
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue[800],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Bonjour",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text("Abdou",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                )),
                            Text(
                              "Calavi,sos",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),

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
                        boutonCategorie(Icons.person, "Médecins",
                            () => print("Médecins cliqué")),
                        boutonCategorie(Icons.local_pharmacy, "Pharmacie",
                            () => print("Pharmacie cliquée")),
                        boutonCategorie(Icons.local_hospital, "Hôpital",
                            () => print("Hôpital cliqué")),
                        boutonCategorie(
                            Icons.apps, "Plus", () => print("Plus cliqué")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // PageView avec conseils de santé dans un seul Container
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: conseilsSante.length,
                  onPageChanged: (index) {
                    setState(() {
                      indexActuel = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset(
                            conseilsSante[index]["image"]!,
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conseilsSante[index]["titre"]!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(conseilsSante[index]["description"]!),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                    width: indexActuel == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: indexActuel == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Section spécialiste
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Specialités",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      "Voir plus",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Liste horizontale des spécialités
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialites.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          indexSelectionne =
                              index; // Mettre à jour l'index sélectionné
                          selectedSpecialite = specialites[index]
                              .libelle; // Récupérer l'ID de la spécialité
                          loadDoctorsBySpecialite(
                              selectedSpecialite!); // Charger les médecins
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 110,
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade100),
                          color: indexSelectionne == index
                              ? Colors.blue
                              : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              specialites[index].libelle,
                              style: TextStyle(
                                fontSize: 13,
                                color: indexSelectionne == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Section clinique a proximité
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Près de vous",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      "Voir plus",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
              SizedBox(height: hauteurEcran * 0.01),
              Padding(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: SizedBox(
                    height: hauteurEcran * 0.30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: discover.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () => setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Cardio()),
                                );
                              }),
                          child: Container(
                              margin:
                                  EdgeInsets.only(right: largeurEcran * 0.05),
                              width: largeurEcran * 0.55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.2), //rend l'ombre semi transparente
                                      spreadRadius: 2, //expansion de l'omnbre
                                      blurRadius:
                                          5, //controle le flou de l'ombre
                                      offset: Offset(
                                          0, 3), //decale l'ombre de 3pixels
                                    )
                                  ]),
                              child: Column(children: [
                                Expanded(
                                    flex: 2,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      discover[index]
                                                          ["image"]!),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.favorite,
                                                size: largeurEcran * 0.05,
                                                color: Colors.pink,
                                              ),
                                            ))
                                      ],
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: largeurEcran,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            discover[index]["texte"]!,
                                            style: TextStyle(
                                                fontSize: largeurEcran * 0.04,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                )
                              ]))),
                    )),
              ),

              SizedBox(height: 20),

              // Liste des médecins disponibles avec images (commentée)
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Médecins disponibles",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      "Voir plus",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: SizedBox(
                    height: hauteurEcran * 0.30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctors.length,
                        itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(right: largeurEcran * 0.05),
                            width: largeurEcran * 0.55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.2), //rend l'ombre semi transparente
                                    spreadRadius: 2, //expansion de l'omnbre
                                    blurRadius: 5, //controle le flou de l'ombre
                                    offset: Offset(
                                        0, 3), //decale l'ombre de 3pixels
                                  )
                                ]),
                            child: Column(children: [
                              Expanded(
                                  flex: 2,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    doctors[index].photo),
                                                fit: BoxFit.cover)),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.favorite,
                                              size: largeurEcran * 0.05,
                                              color: Colors.pink,
                                            ),
                                          ))
                                    ],
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    width: largeurEcran,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 15,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 15, left: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  doctors[index].nom,
                                                  style: TextStyle(
                                                      fontSize:
                                                          largeurEcran * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 15, left: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  doctors[index].specialite,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black87),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                 Pagedetailsdoctor(doctor:doctors[index])));
                                                  },
                                                  child: Text(
                                                    "Voir plus",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                            ]))),
                  )),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Boutons cliquables
  Widget boutonCategorie(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.white),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
