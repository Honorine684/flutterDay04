import 'package:flutter/material.dart';

class CreneauxSelector extends StatefulWidget {
  final List<Map<String, dynamic>> creneaux;
  final Function(String)? onCreneauSelected;

  const CreneauxSelector({
    super.key,
    required this.creneaux,
    this.onCreneauSelected,
  });

  @override
  CreneauxSelectorState createState() => CreneauxSelectorState();
}

class CreneauxSelectorState extends State<CreneauxSelector> {
  String? selectedCreneau;
  int? expandedDayIndex;

  // Fonction pour générer les créneaux horaires à partir de startHour et endHour
  List<String> generateHourSlots(int startHour, int startMinute, int endHour, int endMinute) {
    List<String> slots = [];
    
    // Générer des créneaux d'une heure
    for (int hour = startHour; hour < endHour; hour++) {
      // Format l'heure avec 2 chiffres (ex: 09:00)
      String formattedHour = hour.toString().padLeft(2, '0');
      String formattedMinute = startMinute.toString().padLeft(2, '0');
      
      slots.add('$formattedHour:$formattedMinute');
    }
    
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 4.0),
          child: Text(
            "Créneaux disponibles",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        for (int i = 0; i < widget.creneaux.length; i++)
          _buildJourSection(widget.creneaux[i], i),
      ],
    );
  }

  Widget _buildJourSection(Map<String, dynamic> jourData, int index) {
    final jour = jourData["jour"] as String? ?? 'Jour inconnu';
    final estDisponible = jourData["estDisponible"] as bool? ?? false;
    
    // Récupérer la sous-liste de créneaux pour ce jour
    List<Map<String, dynamic>> creneauxJour = [];
    if (jourData.containsKey("creneaux") && jourData["creneaux"] is List) {
      creneauxJour = List<Map<String, dynamic>>.from(jourData["creneaux"]);
    }
    
    // Générer les heures disponibles à partir des créneaux
    List<String> heuresDisponibles = [];
    for (var creneau in creneauxJour) {
      int startHour = creneau["startHour"] ?? 9;
      int startMinute = creneau["startMinute"] ?? 0;
      int endHour = creneau["endHour"] ?? 17;
      int endMinute = creneau["endMinute"] ?? 0;
      
      heuresDisponibles.addAll(
        generateHourSlots(startHour, startMinute, endHour, endMinute)
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bouton du jour
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: estDisponible ? Colors.blue : Colors.grey,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: estDisponible ? () {
              setState(() {
                if (expandedDayIndex == index) {
                  expandedDayIndex = null; // Fermer si déjà ouvert
                } else {
                  expandedDayIndex = index; // Ouvrir ce jour
                }
              });
              
              // Débogage
              debugPrint("Heures disponibles pour $jour: $heuresDisponibles");
            } : null, // Désactiver le bouton si le jour n'est pas disponible
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  jour,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (estDisponible)
                  Icon(
                    expandedDayIndex == index 
                        ? Icons.keyboard_arrow_up 
                        : Icons.keyboard_arrow_down,
                  ),
              ],
            ),
          ),
        ),
        
        // Afficher les heures seulement si ce jour est développé
        if (expandedDayIndex == index && estDisponible)
          heuresDisponibles.isEmpty 
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Aucun créneau disponible pour ce jour"),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: heuresDisponibles.map((heure) {
                      final creneauString = "$jour à $heure";
                      final isSelected = selectedCreneau == creneauString;
                      
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.green : Colors.grey[200],
                          foregroundColor: isSelected ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedCreneau = creneauString;
                          });
                          
                          if (widget.onCreneauSelected != null) {
                            widget.onCreneauSelected!(creneauString);
                          }
                        },
                        child: Text(heure),
                      );
                    }).toList(),
                  ),
                ),
      ],
    );
  }
}