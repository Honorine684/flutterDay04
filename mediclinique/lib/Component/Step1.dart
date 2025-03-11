import 'package:flutter/material.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() {
    return Step1State();
  }
}



class Step1State extends State<Step1> {
  
  final formKey = GlobalKey<FormState>();
  //controller de texte
  final username = TextEditingController();
  final email = TextEditingController();
  final passWord = TextEditingController();
  final confirmPassword = TextEditingController();
  final adresse = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isLoading = false;
  // verification email
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value!.isNotEmpty && !regex.hasMatch(value)) {
      return "Entrez un email valide";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // username

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
          child: TextFormField(
            controller: username,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              border: InputBorder.none,
              hintText: "Nom complet",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "le nom est obligatoire";
              } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(username.text)) {
                return "Le nom ne peut contenir que des lettres";
              }
              return null;
            },
          ),
        ),
        // email
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
          child: TextFormField(
              controller: username,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                border: InputBorder.none,
                hintText: "Email",
              ),
              validator: validateEmail),
        ),
        // adresse
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
          child: TextFormField(
            controller: adresse,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              border: InputBorder.none,
              hintText: "Adresse(optionnel)",
            ),
          ),
        ),

        //password
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
          child: TextFormField(
            controller: passWord,
            // pour verifier si le champ est bien rempli
            validator: (value) {
              if (value!.isEmpty) {
                return "Mot de passe obligatoire";
              } else if ((passWord.text).length < 6) {
                return "Le mot de passe doit contenir plus de 6 caractères";
              } else if (!RegExp(r'[a-zA-Z]').hasMatch(passWord.text)) {
                return "Le mot de passe doit contenir des lettres";
              } else if (!RegExp(r'\d').hasMatch(passWord.text)) {
                return "Le mot de passe doit contenir des nombres";
              } else if ((passWord.text).contains(' ')) {
                return "Le mot de passe ne peut contenir d'espace";
              }
              return null;
            },
            obscureText: !showPassword,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: InputBorder.none,
                hintText: "Password",
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    showPassword = !showPassword;
                  }),
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                )),
          ),
        ),
        //confirmpassword
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
          child: TextFormField(
            controller: confirmPassword,
            // pour verifier si le champ est bien rempli
            validator: (value) {
              if (value!.isEmpty) {
                return "Confirmer votre mot de passe";
              } else if (passWord.text != confirmPassword.text) {
                return "Les mots de passe ne correspondent pas";
              }
              return null;
            },
            obscureText: !showConfirmPassword,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: InputBorder.none,
                hintText: "Confirm Password",
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  }),
                  icon: Icon(showConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                )),
          ),
        ),
      ]),
    );
  }
}
