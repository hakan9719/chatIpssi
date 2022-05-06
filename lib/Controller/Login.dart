import 'package:flutter/material.dart';
import 'package:chatipssi/View/Dashboard.dart';
import 'package:chatipssi/functions/FirestoreHelper.dart';
import 'package:chatipssi/library/lib.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login>{
  //Variables
  String email = "";
  String password = "";

  //Functions
  dialogue(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Votre mail/mot de passe à été mal saisie"),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")
              )
            ],
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }
  Widget bodyPage(){
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: "Votre mail",
          ),
          onChanged: (text){
            setState(() {
              email=text;
            });
          },
        ),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "Mot de passe",
          ),
          onChanged: (text){
            setState(() {
              password=text;
            });
          },
        ),
        ElevatedButton(
            onPressed: (){
              FirestoreHelper().login(email,password).then((value){
                setState(() {
                  myUser = value;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Dashboard();
                }));
              }).catchError((error){
                dialogue();
              });
            },
            child: const Text("Connexion")
        )
      ],
    );
  }
}