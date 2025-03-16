import 'package:flutter/material.dart';

class DossierMedical extends StatefulWidget {
  const DossierMedical({super.key});

  @override
  _DossierMedicalState createState() => _DossierMedicalState();
}

class _DossierMedicalState extends State<DossierMedical> {
  int clickedIndex = 0; // Indice de l'élément sélectionné
  TextEditingController _searchController = TextEditingController(); // Contrôleur de la zone de recherche

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dossier Médical"),
        backgroundColor: Colors.blue,
      ),
      drawer: MedicalDrawer(
        clickedIndex: clickedIndex,
        onItemSelected: (index) {
          setState(() {
            clickedIndex = index;
          });
          Navigator.pop(context); // Fermer le drawer après la sélection
        },
      ),
      body: Column(
        children: [
          // Zone de recherche et bouton sous l'AppBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Zone de recherche
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Recherche...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                // Bouton prise de rendez-vous
                IconButton(
                  icon: Icon(Icons.event_available),
                  onPressed: () {
                    // Action à définir pour la prise de rendez-vous
                    print("Prise de rendez-vous");
                  },
                ),
              ],
            ),
          ),
          // Affichage de la page sélectionnée
          Expanded(child: _getSelectedPage()),
        ],
      ),
    );
  }

  // Retourne la page correspondant à l'index sélectionné
  Widget _getSelectedPage() {
    switch (clickedIndex) {
      case 0:
        return InformationsPage();
      case 1:
        return AntecedentsPage();
      case 2:
        return ConsultationsPage();
      case 3:
        return ExamensPage();
      case 4:
        return TraitementsPage();
      default:
        return InformationsPage();
    }
  }
}

// ---------- DRAWER ----------
class MedicalDrawer extends StatelessWidget {
  final int clickedIndex;
  final Function(int) onItemSelected;

  MedicalDrawer({required this.clickedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Informations du patient
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID Patient", style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text("PAT-24031101", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Marie Dupont", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("15/06/1975 (50 ans)", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          // Liste des sections du menu
          _buildDrawerItem(0, Icons.info, "Informations"),
           _buildDrawerItem(1, Icons.history, "Antécédents"),
          _buildDrawerItem(2, Icons.local_hospital, "Consultations"),
          _buildDrawerItem(3, Icons.file_copy, "Examens"),
          _buildDrawerItem(4, Icons.medication, "Traitements"),
          Divider(),
          ListTile(
            leading: Icon(Icons.download, color: Colors.black),
            title: Text("Exporter le dossier", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Fonction pour générer les items du drawer
  Widget _buildDrawerItem(int index, IconData icon, String title) {
    bool isSelected = clickedIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      tileColor: isSelected ? Colors.blue : Colors.transparent, // Fond bleu si sélectionné
      onTap: () => onItemSelected(index), // Met à jour l'élément actif
    );
  }
}

// ---------- CONTENU DES PAGES ----------
class InformationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations personnelles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            _buildInfoTable([
              _buildTableRow("Nom", "Dupont"),
              _buildTableRow("Prénom", "Marie"),
              _buildTableRow("Date de naissance", "15/06/1975"),
              _buildTableRow("Sexe", "Féminin"),
              _buildTableRow("Adresse", "23 Rue des Lilas, 75020 Paris"),
              _buildTableRow("Téléphone", "06 12 34 56 78"),
              _buildTableRow("Email", "marie.dupont@email.fr"),
              _buildTableRow("Numéro Sécurité Sociale", "2 75 06 75 123 456 78"),
            ]),

            const SizedBox(height: 24),
            const Text(
              'Informations médicales',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            _buildInfoTable([
              _buildTableRow("Groupe sanguin", "O+"),
              _buildTableRow("Allergies", "Pollen, Antibiotiques"),
              _buildTableRow("Antécédents médicaux", "Diabète, Hypertension"),
              _buildTableRow("Traitements en cours", "Metformine, Aténolol"),
              _buildTableRow("Vaccinations", "Covid-19, Hépatite B"),
            ]),

            const SizedBox(height: 24),
            const Text(
              'Informations d’urgence',
              style: TextStyle(    fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            _buildInfoTable([
              _buildTableRow("Contact d'urgence", "Jean Dupont"),
              _buildTableRow("Téléphone d'urgence", "06 98 76 54 32"),
              _buildTableRow("Médecin traitant", "Dr. Bernard Martin"),
            ]),

            const SizedBox(height: 24),
            const Text(
              'Informations administratives',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            _buildInfoTable([
              _buildTableRow("Numéro de dossier médical", "MD-123456"),
              _buildTableRow("Statut d'assurance", "Mutuelle Santé Plus"),
              _buildTableRow("Profession", "Enseignante"),
            ]),

            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Ajouter une note'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fonction pour générer un tableau avec des informations
  Widget _buildInfoTable(List<TableRow> rows) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey.shade300),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
        },
        children: rows,
      ),
    );
  }

  /// Fonction pour générer une ligne de tableau
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$label:",
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class AntecedentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding( padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("🏡 Antécédents Familiaux"),
              _buildInfoCard([
                "Hypertension artérielle",
                "Diabète",
                "Maladies cardiovasculaires",
                "Cancer (sein, prostate, colorectal)",
                "Maladies neurologiques (Alzheimer, Parkinson)",
              ]),

              _buildSectionTitle("🩺 Antécédents Médicaux Personnels"),
              _buildInfoCard([
                "Diabète de type 2",
                "Asthme depuis l'enfance",
                "Insuffisance rénale (stade 2)",
                "Antécédents d’AVC léger",
              ]),

              _buildSectionTitle("🔪 Antécédents Chirurgicaux"),
              _buildInfoCard([
                "Appendicectomie en 2015",
                "Chirurgie du genou (fracture) en 2018",
              ]),

              _buildSectionTitle("👩‍⚕️ Antécédents Gynécologiques"),
              _buildInfoCard([
                "Grossesse en 2020 (césarienne)",
                "Endométriose diagnostiquée en 2019",
              ]),

              _buildSectionTitle("🌿 Allergies"),
              _buildInfoCard([
                "Allergie aux antibiotiques (pénicilline)",
                "Allergie au pollen et aux acariens",
              ]),

              _buildSectionTitle("💊 Antécédents Médicamenteux"),
              _buildInfoCard([
                "Médicaments pour l’hypertension",
                "Traitement anticoagulant",
              ]),

              _buildSectionTitle("🚬 Mode de Vie"),
              _buildInfoCard([
                "Fumeur occasionnel",
                "Consommation d'alcool modérée",
                "Pratique du sport 2 fois par semaine",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// Fonction pour afficher le titre d'une section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  /// Fonction pour afficher une carte contenant des informations
  Widget _buildInfoCard(List<String> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => _buildInfoRow(item)).toList(),
        ),
      ),
    );
  }

  /// Fonction pour afficher chaque élément d'une liste avec une icône
  Widget _buildInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ConsultationsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("📅 Date & Médecin"),
              _buildInfoCard([
                "Date : 10 Mars 2025",
                "Médecin : Dr. Pierre Dubois (Généraliste)",
                "Lieu : Hôpital Saint-Louis, Paris",
              ]),

              _buildSectionTitle("🤒 Motif de la Consultation"),
              _buildInfoCard([
                "Raison : Douleurs abdominales intenses",
                "Durée : 3 jours",
                "Circonstances : Après un repas lourd",
              ]),

              _buildSectionTitle("🩺 Examen Clinique"),
              _buildInfoCard([
                "Température : 38.2°C",
                "Tension artérielle : 120/80 mmHg",
                "Poids : 70 kg, Taille : 1.75m (IMC : 22.9)",
                "Fréquence cardiaque : 80 bpm",
              ]),

              _buildSectionTitle("🧪 Examens Complémentaires"),
              _buildInfoCard([
                "Analyses demandées : Test sanguin, bilan hépatique",
                "Imagerie : Échographie abdominale",
                "Autres : Test Helicobacter pylori",
              ]),

              _buildSectionTitle("🏷 Diagnostic & Conclusion"),
              _buildInfoCard([
                "Diagnostic : Gastrite aiguë",
                "Complications possibles : Ulcère",
              ]),

              _buildSectionTitle("💊 Traitement & Recommandations"),
              _buildInfoCard([
                "Médicaments : IPP (Oméprazole) - 20mg/jour pendant 2 semaines",
                "Recommandations : Éviter les repas épicés et l'alcool",
                "Repos : Repos digestif conseillé",
                "Prochain RDV : 24 Mars 2025",
              ]),

              _buildSectionTitle("📌 Notes du Médecin & Suivi"),
              _buildInfoCard([
                "Surveillance des symptômes pendant 1 semaine",
                "Revoir en cas d'aggravation (vomissements, fièvre persistante)",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// Fonction pour afficher le titre d'une section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
    /// Fonction pour afficher une carte contenant des informations
  Widget _buildInfoCard(List<String> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => _buildInfoRow(item)).toList(),
        ),
      ),
    );
  }

  /// Fonction pour afficher chaque élément d'une liste avec une icône
  Widget _buildInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ExamensPage extends StatelessWidget {
  final List<Map<String, String>> examens = [
    {
      "date": "15/02/2025",
      "type": "Bilan sanguin",
      "motif": "Suivi diabète",
      "medecin": "Dr. Bernard Martin",
      "etablissement": "Laboratoire BioSanté",
      "resultats": "Glycémie : 1.2 g/L, Cholestérol : 1.8 g/L",
      "interpretation": "Résultats normaux, à surveiller",
    },
    {
      "date": "10/10/2024",
      "type": "Radiographie pulmonaire",
      "motif": "Toux persistante",
      "medecin": "Dr. Sophie Moreau",
      "etablissement": "Clinique St-Michel",
      "resultats": "Aucune anomalie détectée",
      "interpretation": "Poumons sains",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examens du Patient"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: examens.length,
                itemBuilder: (context, index) {
                  return _buildExamenCard(examens[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter un examen
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// Fonction pour afficher une carte d'examen avec un design soigné
  Widget _buildExamenCard(Map<String, String> examen) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  examen["type"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  examen["date"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.medical_services, "Motif", examen["motif"]!),
            _buildDetailRow(Icons.person, "Médecin", examen["medecin"]!),
            _buildDetailRow(Icons.local_hospital, "Établissement", examen["etablissement"]!),
            _buildDetailRow(Icons.analytics, "Résultats", examen["resultats"]!),
            _buildDetailRow(Icons.comment, "Interprétation", examen["interpretation"]!),
          ],
        ),
      ),
    );
  }

  /// Fonction pour afficher une ligne d'information avec une icône
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 8),
          Text(
            "$label : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class TraitementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Traitement du Patient"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Ajouter une note'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 5,  shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Nom du Traitement", "Antibiothérapie pour infection urinaire"),
            _buildSection("Type de Traitement", "Médical (médicaments)"),
            _buildSection("Date de Début", "05/03/2025"),
            _buildSection("Durée du Traitement", "7 jours"),
            _buildSection("Médicaments Prescrits", "Amoxicilline 500 mg, 3 fois par jour"),
            _buildSection("Objectifs du Traitement", "Guérison de l'infection urinaire"),
            _buildSection("Évolution du Traitement", "Bonne réponse au traitement, réduction des symptômes"),
            _buildSection("Effets Secondaires", "Léger mal de ventre"),
            _buildSection("Médecin Prescripteur", "Dr. Emma Dupont, généraliste"),
            _buildSection("Suivi Recommandé", "Contrôle urinaire dans 10 jours"),
            _buildSection("Instructions Spéciales", "Prendre le médicament après les repas"),
            _buildSection("Commentaires du Patient", "Aucun effet secondaire majeur ressenti"),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}