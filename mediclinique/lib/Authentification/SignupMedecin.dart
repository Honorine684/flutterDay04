import 'package:flutter/material.dart';
import 'package:mediclinique/Component/Step1.dart';
import 'package:mediclinique/Component/Step2.dart';
import 'package:mediclinique/Component/Step3.dart';
import 'package:mediclinique/Component/Step4.dart';
import 'package:mediclinique/Component/Step5.dart';

class Signupmedecin extends StatefulWidget {
  const Signupmedecin({super.key});

  @override
  State<Signupmedecin> createState() {
    return SignupmedecinState();
  }
}

class SignupmedecinState extends State<Signupmedecin> {
  int initialStep = 0;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  Map<String,dynamic> medecinData = {};
  void getStep1Data(Map<String,dynamic> data){
    medecinData.addAll(data);
  }
  void getStep2Data(Map<String,dynamic> data){
    medecinData.addAll(data);
  }
  void getStep3Data(Map<String,dynamic> data){
    medecinData.addAll(data);
  }
    void getStep5Data(Map<String,dynamic> data){
    medecinData.addAll(data);
  }
  List<Step> steps = [
    Step(
      title: Text("Informations personnelles",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Step1(),
      isActive: true,
    ),
    Step(
      title: Text("Encore sur vous",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Step2(),
      isActive: true,
    ),
    Step(
      title: Text("Informations professionnelles",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Step3(),
      isActive: true,
    ),
    Step(
      title: Text("Disponibilités",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Step5(),
      isActive: true,
    ),
    Step(
      title: Text("Confirmation",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Step4(),
      isActive: true,
      state: StepState.complete,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hauteurEcran = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
       title: Text("Ajouter un medecin",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: hauteurEcran * 0.02),

          
          Stepper(
            currentStep: initialStep,
            type: StepperType.vertical,
            steps: steps,
            onStepTapped: (value) {
              setState(() {
                initialStep = value;
              });
            },
            onStepContinue: () {
              setState(() {
                if (initialStep < steps.length - 1) {
                  initialStep = initialStep + 1;
                } else {
                  initialStep = 0;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (initialStep > 0) {
                  initialStep = initialStep - 1;
                } else {
                  initialStep = 0;
                }
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text('Annuler', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                     
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text('Continuer', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                    onPressed: initialStep == steps.length - 1 
                      ? () {
                          
                          //print("Données collectées: $medecinData");
                       
                        }
                      : details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      initialStep == steps.length - 1 ? 'Confirmer' : 'Continuer', 
                      style: TextStyle(fontSize: 16)
                    ),
                  ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
