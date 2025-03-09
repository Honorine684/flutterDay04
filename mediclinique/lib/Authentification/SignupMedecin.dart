import 'package:flutter/material.dart';
import 'package:mediclinique/Component/Step1.dart';

class Signupmedecin extends StatefulWidget{
  const Signupmedecin({super.key});

  @override
  State<Signupmedecin> createState() {
   return SignupmedecinState();
  }
  
}
class SignupmedecinState extends State<Signupmedecin>{
  int initialStep = 0;
  List<Step> steps = [
    Step(
      title: Text("Informations personnelles",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 
      content: Step1(),
      isActive: true,
      ),
      Step(
      title: Text("Informations personnelles",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 
      content: Step1(),
      isActive: true,
      subtitle: Text("Etape3")
      ),
      Step(
      title: Text("Informations personnelles",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), 
      content: Step1(),
      isActive: true,
      state: StepState.complete,
      subtitle: Text("Etape2")
      )
  ];

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/login.jpg",width: largeurEcran,),
            SizedBox(height: hauteurEcran*0.02,),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Svp inscrivez-vous pour continuer"),
              ],
            )
            ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
            Stepper(
              currentStep: initialStep,
              type: StepperType.vertical,
              steps: steps,
              onStepTapped: (value){
                setState(() {
                  initialStep = value;

                });
              },
              onStepContinue: () {
                setState(() {
                  if(initialStep < steps.length-1){
                    initialStep = initialStep+1;
                  }else{
                    initialStep = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if(initialStep > 0){
                    initialStep = initialStep-1;
                  }else{
                    initialStep=0;
                  }
                });
              },
              ),
          ],
        ),
      ),
    );
  }
  
}