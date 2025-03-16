import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediclinique/Pages/DossierMedical.dart';
import 'package:mediclinique/Services/Firebase/FirestoreService.dart';


class AjoutConsultation extends StatefulWidget {
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  const AjoutConsultation({
    super.key, 
    required this.patientId, 
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  AjoutConsultationState createState() => AjoutConsultationState();
}

class AjoutConsultationState extends State<AjoutConsultation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _consultationDateController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _surgicalHistoryController = TextEditingController();
  final TextEditingController _familyHistoryController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
    final TextEditingController chroniqueController = TextEditingController();

  final TextEditingController _currentTreatmentsController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _generalExamController = TextEditingController();
  final TextEditingController _cardiovascularExamController = TextEditingController();
  final TextEditingController _respiratoryExamController = TextEditingController();
  final TextEditingController _digestiveExamController = TextEditingController();
  final TextEditingController _neurologicalExamController = TextEditingController();
  final TextEditingController _musculoskeletalExamController = TextEditingController();
  final TextEditingController _otherExamsController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

 String? selectedDoctor;


  @override
  void initState() {
    super.initState();
    _consultationDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

  _patientIdController.text = widget.patientId;
  
  selectedDoctor = widget.doctorName;
    // Ajouter des listeners pour le calcul automatique de l'IMC
    _weightController.addListener(_calculateBMI);
    _heightController.addListener(_calculateBMI);
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _consultationDateController.dispose();
    _medicalHistoryController.dispose();
    _surgicalHistoryController.dispose();
    _familyHistoryController.dispose();
    _allergiesController.dispose();
    _currentTreatmentsController.dispose();
    _temperatureController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _bmiController.dispose();
    _generalExamController.dispose();
    _cardiovascularExamController.dispose();
    _respiratoryExamController.dispose();
    _digestiveExamController.dispose();
    _neurologicalExamController.dispose();
    _musculoskeletalExamController.dispose();
    _otherExamsController.dispose();
    _diagnosisController.dispose();
    _planController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    if (_weightController.text.isNotEmpty && _heightController.text.isNotEmpty) {
      try {
        double weight = double.parse(_weightController.text);
        double height = double.parse(_heightController.text) / 100; // Convert to meters
        double bmi = weight / (height * height);
        _bmiController.text = bmi.toStringAsFixed(2);
      } catch (e) {
        _bmiController.text = '';
      }
    } else {
      _bmiController.text = '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _consultationDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      Firestoreservice().addConsultation(_patientIdController.text, widget.patientName, _consultationDateController.text, 
      widget.doctorId, widget.doctorName, _medicalHistoryController.text, _familyHistoryController.text, _surgicalHistoryController.text,
      _allergiesController.text,_currentTreatmentsController.text, _temperatureController.text, _systolicController.text, _diastolicController.text,  _heartRateController.text, _weightController.text, 
      _heightController.text, _generalExamController.text,_cardiovascularExamController.text, _respiratoryExamController.text,_digestiveExamController.text, 
       _neurologicalExamController.text, _musculoskeletalExamController.text,_otherExamsController.text, _diagnosisController.text,_planController.text,_notesController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation enregistrée avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout de Consultation'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildSectionTitle('Informations Patient'),
              const SizedBox(height: 15),
              _buildPatientInfoSection(),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Antécédents'),
              const SizedBox(height: 15),
              _buildMedicalHistorySection(),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Examen Clinique'),
              const SizedBox(height: 15),
              _buildClinicalExamSection(),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Conclusion et Plan'),
              const SizedBox(height: 15),
              _buildConclusionSection(),
              const SizedBox(height: 30),
              
              _buildSubmitButtons(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.blue,
            width: 4,
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildPatientInfoSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _patientIdController,
                decoration: const InputDecoration(
                  labelText: "Id patient"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir l\'ID du patient';
                  }
                  return null;
                },
                readOnly: true, 
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _consultationDateController,
                decoration: const InputDecoration(
                  labelText: 'Date de consultation',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
            ),
          ],
        ),
      const SizedBox(height: 16),
      TextFormField(
        initialValue: widget.doctorName,
        decoration: const InputDecoration(
          labelText: 'Médecin',
        ),
        readOnly: true, 
      ),
      ],
    );
  }

  Widget _buildMedicalHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _medicalHistoryController,
          decoration: const InputDecoration(
            labelText: 'Antécédents Médicaux',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
              TextFormField(
        controller: chroniqueController,
        decoration: const InputDecoration(
          labelText: 'Maladies chroniques',
        ),
        maxLines: 3,
      ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _surgicalHistoryController,
          decoration: const InputDecoration(
            labelText: 'Antécédents Chirurgicaux',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _familyHistoryController,
          decoration: const InputDecoration(
            labelText: 'Antécédents Familiaux',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _allergiesController,
          decoration: const InputDecoration(
            labelText: 'Allergies',
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _currentTreatmentsController,
          decoration: const InputDecoration(
            labelText: 'Traitements en cours',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildClinicalExamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Constantes Vitales',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _temperatureController,
                decoration: const InputDecoration(
                  labelText: 'Température (°C)',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _systolicController,
                      decoration: const InputDecoration(
                        labelText: 'TA - Systolique',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('/'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _diastolicController,
                      decoration: const InputDecoration(
                        labelText: 'TA - Diastolique',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _heartRateController,
                decoration: const InputDecoration(
                  labelText: 'Fréquence cardiaque (bpm)',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Poids (kg)',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Taille (cm)',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _bmiController,
                decoration: const InputDecoration(
                  labelText: 'IMC',
                ),
                readOnly: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _generalExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Général',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cardiovascularExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Cardiovasculaire',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _respiratoryExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Respiratoire',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _digestiveExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Digestif',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _neurologicalExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Neurologique',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _musculoskeletalExamController,
          decoration: const InputDecoration(
            labelText: 'Examen Ostéo-articulaire',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _otherExamsController,
          decoration: const InputDecoration(
            labelText: 'Autres observations',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildConclusionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _diagnosisController,
          decoration: const InputDecoration(
            labelText: 'Diagnostic(s)',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _planController,
          decoration: const InputDecoration(
            labelText: 'Plan de traitement',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            labelText: 'Notes supplémentaires',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSubmitButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text('Annuler'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: (){
    Map<String, dynamic> consultationData = {
      'patientId': widget.patientId,
      'patientName': widget.patientName,
      'doctorName': widget.doctorName,
      'consultationDate': _consultationDateController.text,
      'medicalHistory': _medicalHistoryController.text,
      'surgicalHistory': _surgicalHistoryController.text,
      'familyHistory': _familyHistoryController.text,
      'allergies': _allergiesController.text,
      'currentTreatments': _currentTreatmentsController.text,
      'temperature': _temperatureController.text,
      'systolic': _systolicController.text,
      'diastolic': _diastolicController.text,
      'heartRate': _heartRateController.text,
      'weight': _weightController.text,
      'height': _heightController.text,
      'generalExam': _generalExamController.text,
      'cardiovascularExam': _cardiovascularExamController.text,
      'respiratoryExam': _respiratoryExamController.text,
      'digestiveExam': _digestiveExamController.text,
      'neurologicalExam': _neurologicalExamController.text,
      'musculoskeletalExam': _musculoskeletalExamController.text,
      'otherExams': _otherExamsController.text,
      'diagnosis': _diagnosisController.text,
      'plan': _planController.text,
      'notes': _notesController.text,
      };

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DossierMedical(
          patientId: widget.patientId,
          patientName: widget.patientName,
          consultationData: consultationData,
        )
      )
    );
        
            
            submitForm();
           Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => DossierMedical(
        patientId: widget.patientId,
        patientName: widget.patientName,  
      )
    )
  );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text('Enregistrer'),
        ),
        const SizedBox(width: 16),
       /* ElevatedButton(
          onPressed: () {
            _submitForm();
            // Ajouter le code pour imprimer ici
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text('Enregistrer et imprimer'),
        ),*/
      ],
    );
  }
}