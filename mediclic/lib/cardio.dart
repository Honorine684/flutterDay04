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
        child: SafeArea(child: 
        SingleChildScrollView(
          child: 
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,
                    border: Border.all(color: Colors.grey,
                    width: 1)),
                    child: Icon(Icons.arrow_back),
                  ),
                  Text('Cardiologue',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,
                    border: Border.all(color: Colors.grey,
                    width: 1)),
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Les spécialistes'),
                  Icon(Icons.menu)
                ],
              ),
              Container(
                width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                child: Row(
                  children: [
                    Image.asset('assets/images/'),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Dr John ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            Text("UK Medical (cardiologue)",style: TextStyle(color: Colors.grey,fontSize: 10),),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.yellow,)
                              ]
                            )
                            
                          ],
                        )
                      ],
                    )
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