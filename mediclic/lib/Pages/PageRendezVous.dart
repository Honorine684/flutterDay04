import 'package:flutter/material.dart';

class Pagerendezvous extends StatefulWidget{
  const Pagerendezvous({super.key});

  @override
  State<Pagerendezvous> createState() {
    return PagerendezvousState();
  }
  
}

class PagerendezvousState extends State<Pagerendezvous>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Vos rendez vous"),
      ),
    );
  }
  
}