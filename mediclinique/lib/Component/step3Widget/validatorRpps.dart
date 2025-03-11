import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RPPSValidator {
  // Vérifie si le format du RPPS est valide (11 chiffres)
  static bool isValidFormat(String rpps) {
    final RegExp regExp = RegExp(r'^\d{11}$');
    return regExp.hasMatch(rpps);
  }
  
  // Vérifie la clé de contrôle avec l'algorithme de Luhn
  static bool isValidChecksum(String rpps) {
    if (rpps.length != 11) return false;
    
    int sum = 0;
    bool alternate = false;
    
    for (int i = rpps.length - 1; i >= 0; i--) {
      int n = int.parse(rpps[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }
    
    return (sum % 10 == 0);
  }
  
  // Méthode principale de validation
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro RPPS est obligatoire';
    }
    
    if (!isValidFormat(value)) {
      return 'Le numéro RPPS doit contenir exactement 11 chiffres';
    }
    
    if (!isValidChecksum(value)) {
      return 'Numéro RPPS invalide, veuillez vérifier les chiffres saisis';
    }
    
    return null; 
  }
}


class RPPSFormField extends StatelessWidget {
  const RPPSFormField({super.key});



  @override
  Widget build(BuildContext context) {
    final rpps = TextEditingController();
    final formKey1 = GlobalKey<FormState>();
    return Form
    
    (
      key: formKey1,
      child: 
    
    Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
          child: 
    TextFormField(
      controller: rpps,
     decoration: const InputDecoration(
              icon: Icon(Icons.badge),
              border: InputBorder.none,
              hintText: "RPPS(numero unique)",
            ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      validator: RPPSValidator.validate,
      
    ))
    );
  }

  
  }
