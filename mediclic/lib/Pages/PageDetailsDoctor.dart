import 'package:flutter/material.dart';
import 'package:mediclic/JsonModels/Doctor.dart';
import 'package:mediclic/Pages/PriseDeRendezVous.dart';

class Pagedetailsdoctor extends StatefulWidget{
  final Doctor doctor ;
  const Pagedetailsdoctor(
    {
      super.key,
      required this.doctor
      });

  @override
  State<Pagedetailsdoctor> createState() {
   return PagedetailsdoctorState();
  }

}
class PagedetailsdoctorState extends State<Pagedetailsdoctor>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>  Prisederendezvous()));
        },
        child: Text("prendre rendez-vous"),
      ),
    ),
);
  }
  
}