import 'package:flutter/material.dart';
import 'package:mediclinique/Component/Step2Widget/DatePicker.dart';
import 'package:mediclinique/Component/Step2Widget/genreChoice.dart';
import 'package:mediclinique/Component/Step2Widget/photo.dart';

class Step2 extends StatelessWidget{
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
  return Column(
    children: [
      // date de naissance
      DatePicker(),
      SizedBox(height: 20,),
      //sexe
      Genrechoice(),
      SizedBox(height: 20,),
      Photo(),


    ],
  );
    
    
    

   
  }

  
}
