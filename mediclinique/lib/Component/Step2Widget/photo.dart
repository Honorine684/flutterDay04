import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends StatefulWidget {
  const Photo({super.key});

  @override
  State<Photo> createState() {
    return PhotoState();
  }
}

class PhotoState extends State<Photo> {
  File? image;
  bool showImage = false;

  Future pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {
        return;
      }
      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
        showImage = true;
      });
    } on PlatformException catch (e) {
      print("Erreur lors du chargement de l'image : $e");
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
          showImage
              ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(image!), // Utilisation de FileImage pour afficher l'image
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Text("Photo (optionnel)", style: TextStyle(fontSize: 14)),
          IconButton(
            onPressed: () {
              pickImage();
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // Ajouter la fonctionnalité pour prendre une photo ici
            },
            icon: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}
