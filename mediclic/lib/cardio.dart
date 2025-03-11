import 'package:flutter/material.dart';

class Cardio extends StatefulWidget {
  const Cardio({super.key});

  @override
  State<Cardio> createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(left: 16, right: 16, top: 46),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Cardiologue',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Les spécialités',style: TextStyle(color: Colors.grey),),
                  Icon(Icons.menu,color: Colors.blue,)
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: 1000,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Arrondi de l'image
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/doctor.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Espacement entre l'image et le texte
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dr John",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "UK Medical (cardiologue)",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5), // Espacement avant l'icône
                          Row(
                            children: [
                              Text('Voir details',style: TextStyle(color: Colors.blue),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
