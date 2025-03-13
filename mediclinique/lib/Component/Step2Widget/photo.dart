import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:convert';

class Photo extends StatefulWidget {
  const Photo({super.key, required this.onPhotoChanged});

  final void Function(String? path) onPhotoChanged; // Callback

  @override
  State<Photo> createState() => PhotoState();
}

class PhotoState extends State<Photo> {
  File? image;
  String? base64Image;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }

    // Compresser l'image avant de l'encoder
    final compressedImage = await compressImage(File(pickedImage.path));
    if (compressedImage == null) {
      return;
    }

    // Vérifier la taille de l'image compressée (8 Mo = 8 * 1024 * 1024 octets)
    final fileSize = await compressedImage.length();
    if (fileSize > 8 * 1024 * 1024) {
      // Afficher une alerte si l'image dépasse 8 Mo
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Image trop volumineuse'),
          content: Text('L\'image sélectionnée dépasse 8 Mo même après compression. Veuillez choisir une image moins volumineuse.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(); // Redemander à l'utilisateur de choisir une image
              },
              child: Text('Réessayer'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
          ],
        ),
      );
      return;
    }

    // Encoder l'image compressée en base64
    final bytes = await compressedImage.readAsBytes();
    final base64 = base64Encode(bytes);

    setState(() {
      image = compressedImage;
      base64Image = base64;
    });

    widget.onPhotoChanged(base64Image);
  }

  Future<File?> compressImage(File file) async {
    try {
      final result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 50, // Réduire la qualité à 50%
      );

      if (result == null) {
        return null;
      }

      // Sauvegarder l'image compressée dans un fichier temporaire
      final compressedFile = File('${file.path}_compressed.jpg');
      await compressedFile.writeAsBytes(result);
      return compressedFile;
    } catch (e) {
      print("Erreur lors de la compression de l'image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        children: [
          image != null
              ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Text("Photo (optionnel)", style: TextStyle(fontSize: 14)),
          IconButton(
            onPressed: pickImage,
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}