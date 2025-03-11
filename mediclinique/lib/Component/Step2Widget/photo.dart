import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    final imageTemporary = File(pickedImage.path);

    // Encoder l'image en base64
    final bytes = await imageTemporary.readAsBytes();
    final base64 = base64Encode(bytes);

    setState(() {
      image = imageTemporary;
      base64Image = base64; 
    });

    widget.onPhotoChanged(base64Image); 
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
