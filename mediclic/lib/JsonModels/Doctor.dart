class Doctor {
  final String id;
  final String nom;
  final String genre;
  final String photo;
  final String specialite;
  final List<Map<String,dynamic>> creneaux;
  Doctor({
    required this.id,
    required this.nom,
    required this.genre,
    required this.photo,
    required this.specialite,
    required this.creneaux
  });
}