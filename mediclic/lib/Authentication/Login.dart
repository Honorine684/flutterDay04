import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclic/Authentication/Signup.dart';
import 'package:mediclic/Component/BottomBar.dart';
import 'package:mediclic/Services/Firebase/Auth.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final emailOrPhone = TextEditingController();
  final password = TextEditingController();
  bool showPassword = false;
  bool isRememberMeChecked = false;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool googleLoading = false;


  String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  if(value!.isNotEmpty && !regex.hasMatch(value)){
    return "Entrez un email valide";
  }else{
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                      "assets/image/sign.webp",
                      width: largeurEcran * 0.4,
                      height: hauteurEcran * 0.3,
                    ),
             Text("Se connecter",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
             Text("Svp,connectez-vous pour continuer",style: TextStyle(fontSize: 13,),),
            
                
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: emailOrPhone,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email",
                        
                      ),
                    ),
                  ),

              // Champ mot de passe
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: password,
                  obscureText: !showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mot de passe obligatoire";
                    }
                    return null;
                  },
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
                    ),
                  ),
                ),
              ),

              // Case "Se souvenir de moi"
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: isRememberMeChecked,
                    onChanged: (value) {
                      setState(() {
                        isRememberMeChecked = value!;
                      });
                    },
                  ),
                  Text("Se souvenir de moi"),
                ],
              ),

              // Bouton connexion
              Container(
                width: largeurEcran * 0.9,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed:isLoading ?null: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (formKey.currentState!.validate()) {
                      // Logique de connexion
                      try{
                        await Auth().loginWithEmailAndPassword(
                          emailOrPhone.text,password.text
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Bottombar()));
                        setState(() {
                      isLoading = false;
                    });
                      }on FirebaseAuthException catch(e){
                        setState(() {
                      isLoading = false;
                    });
                        // message d'erreur
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${e.message}"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xffE9494F),
                          showCloseIcon: true,
                          ),
                          
                        );
                      }
                      
                        
                    }
                  },
                  child: isLoading ? const CircularProgressIndicator():
                  Text(
                    "Se connecter",
                    style: TextStyle(
                        fontSize: largeurEcran * 0.04, color: Colors.white),
                  ),
                ),
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pas utilisateur?"),
                    TextButton(
                      child: Text("S'inscrire",style: TextStyle(color: Colors.blue),),
                      onPressed: () => setState(() {
                        // naviguer vers la page d'inscription
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signup()));
                      }),
                    )
                  ],
                ),
              // mot de passe oublié
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Mot de passe oublié?"),
                    TextButton(
                      child:googleLoading ? const CircularProgressIndicator():
                       Text("Se conecter avec google",style: TextStyle(color: Colors.blue),),
                      onPressed: ()async {
                        setState(() {
                          googleLoading = true;
                        });
                      // naviguer vers la page de connexion
                       await Auth().loginWithGoogle();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Bottombar()));
                        setState(() {
                        googleLoading = false;
                       
                      }
              );}),
            ])
                  ],
                ),
            
          ),
        ),
      );
    
  }
}