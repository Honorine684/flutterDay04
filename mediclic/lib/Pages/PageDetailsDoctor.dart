import 'package:flutter/material.dart';
import 'package:mediclic/JsonModels/Doctor.dart';
import 'package:mediclic/Pages/Acceuil.dart';
import 'package:mediclic/Pages/PriseDeRendezVous.dart';

class DetailPageDoctor extends StatefulWidget {
  final Doctor doctor;
  const DetailPageDoctor({super.key, required this.doctor});

  @override
  State<DetailPageDoctor> createState() => _DetailPageDoctorState();
}

class _DetailPageDoctorState extends State<DetailPageDoctor> {
  // Fonction pour formater les créneaux horaires
  String _formatCreneau(Map<String, dynamic> creneau) {
    final startHour = creneau['startHour'] ?? 0; // Valeur par défaut si null
    final startMinute =
        creneau['startMinute']?.toString().padLeft(2, '0') ?? '00';
    final endHour = creneau['endHour'] ?? 0; // Valeur par défaut si null
    final endMinute = creneau['endMinute']?.toString().padLeft(2, '0') ?? '00';

    return '$startHour:$startMinute - $endHour:$endMinute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.all(8),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => setState(() {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Accueil()),
              );
            }),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: Colors.blue,
              child: Image.asset(
                "assets/image/exercice.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: 30,
                    left: 18,
                    right: 18,
                    bottom: 80), // Ajoutez un espace en bas pour le bouton
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom du médecin
                    Text(
                      widget.doctor.nom,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Spécialité du médecin
                    Text(
                      widget.doctor.specialite,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Adresse
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          widget.doctor.adresse,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.doctor.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 24),

                    // Disponibilités
                    Text(
                      "Disponibilités",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    if (widget.doctor.creneaux.isEmpty)
                      Text("Aucun créneau disponible")
                    else
                      Expanded(
                        child: Scrollbar(
                          child: ListView(
                            children:
                                widget.doctor.creneaux.map((jourCreneaux) {
                              final jour = jourCreneaux['jour'];
                              final creneaux =
                                  jourCreneaux['creneaux'] as List<dynamic>;

                              return Card(
                                margin: EdgeInsets.only(bottom: 8),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jour,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      ...creneaux.map((creneau) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 8),
                                          child: Text(
                                            _formatCreneau(creneau),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Bouton "Prendre un rendez-vous" positionné en bas
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Prisederendezvous(doctor: widget.doctor),
                  ),
                );
                print("Prendre un rendez-vous");
              },
              icon: Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24,
              ),
              label: Text(
                "Prendre un rendez-vous",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
