import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

typedef void ImageCallback(File? imageFile, String? base64String);

class Photo extends StatefulWidget {
  final ImageCallback onImageSelected;
  
  const Photo({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  File? image;
  String? base64Image;
  bool isLoading = false;
  String? errorMessage;
  
  // Taille maximale en octets (8 Mo = 8 * 1024 * 1024 octets)
  final int maxSize = 8 * 1024 * 1024;

  Future pickImage() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      
      if (pickedImage == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      
      final imageFile = File(pickedImage.path);
      
      // Vérifier la taille du fichier
      final fileSize = await imageFile.length();
      if (fileSize > maxSize) {
        setState(() {
          errorMessage = 'L\'image dépasse 8 Mo. Veuillez choisir une image plus petite.';
          isLoading = false;
        });
        return;
      }
      
      setState(() {
        image = imageFile;
        isLoading = false;
      });

      // Encoder l'image en base64
      final bytes = await image!.readAsBytes();
      base64Image = base64Encode(bytes);
      
      // Envoyer l'image et sa version base64 au parent
      widget.onImageSelected(image, base64Image);
      
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur lors de la sélection de l\'image: $e';
        isLoading = false;
      });
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
      child: Column(
        children: [
          if (isLoading)
            const CircularProgressIndicator()
          else if (image != null)
            Image.file(
              image!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
          else
            const Icon(
              Icons.image_outlined,
              size: 100,
              color: Colors.grey,
            ),
          const SizedBox(height: 10),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isLoading ? null : pickImage,
            child: const Text('Sélectionner une photo de profil'),
          ),
        ],
      ),
    );
  }
}