import 'package:flutter/material.dart';

class Acceuil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Good morning",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Mosarraf",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Text("Find your doctor...",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                ],
              ))
        ]))));
  }
}
