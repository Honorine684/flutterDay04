import 'package:flutter/material.dart';
import 'package:mediclinique/Authentification/Login.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() {
    return GetstartedState();
  }
}

class GetstartedState extends State<Getstarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Text("Choisissez une option",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF6CFF3).withOpacity(0.2)),
                                child: Image.asset(
                                  "assets/images/login.jpg",
                                  fit: BoxFit.cover,
                                )),
                            Text(
                              "Admin",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF6CFF3).withOpacity(0.2)),
                                child: Image.asset(
                                  "assets/images/login.jpg",
                                  fit: BoxFit.cover,
                                )),
                            Text(
                              "Clinique",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))),
              )
            ],
          ),
        ])));
  }
}
