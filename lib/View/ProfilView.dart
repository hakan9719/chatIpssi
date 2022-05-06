import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatipssi/functions/FirestoreHelper.dart';
import 'package:chatipssi/library/lib.dart';
import 'package:chatipssi/modelView/ImageRond.dart';

class ProfilView extends StatefulWidget{
  const ProfilView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilViewState();
  }
}

class ProfilViewState extends State<ProfilView> {
  //Variables
  String? lienImage;
  Uint8List? bytesImages;
  String? nameImage;

  //Fonctions
  getImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.image
    );
    if(result !=  null){
      setState(() {
        nameImage = result.files.first.name;
        bytesImages = result.files.first.bytes;
      });
      popImage();
    }
  }

  popImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isIOS ){
            return CupertinoAlertDialog(
              title: const Text("Souhaitez-vous utiliser cette photo ?"),
              content: Image.memory(bytesImages!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      //Stocker dans la bdd l'image
                      FirestoreHelper().storageFile(nameImage!, bytesImages!).then((value) {
                        setState(() {
                          lienImage = value;
                          myUser.avatar = lienImage;
                          Map<String,dynamic> map = {
                            "IMAGE": lienImage,
                          };
                          FirestoreHelper().updateUser(myUser.uid, map);
                          Navigator.pop(context);
                        });
                      }
                      );

                    },
                    child: const Text("Ok")
                )
              ],
            );
          }else{
            return AlertDialog(
              title: Text("Souhaitez-vous utiliser cette photo ?"),
              content: Image.memory(bytesImages!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      //Stocker dans la bdd l'image
                      FirestoreHelper().storageFile(nameImage!, bytesImages!).then((value) {
                        setState(() {
                          lienImage = value;
                          myUser.avatar = lienImage;
                          Map<String,dynamic> map = {
                            "IMAGE": lienImage,
                          };
                          FirestoreHelper().updateUser(myUser.uid, map);
                          Navigator.pop(context);
                        });
                      }
                      );


                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      child: bodyPage(),
    );

  }


  Widget bodyPage(){
    return Column(
      children: [
        //Logo de moi
        InkWell(
          child:ImageRond(image: myUser.avatar,size: 150,),
          onTap: (){
            print("Click image");
            getImage();
          },
        ),


        //NOm et prénom
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                    hintText: myUser.firstname,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onChanged: (newValue){
                  setState(() {
                    myUser.firstname = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "FIRSTNAME": myUser.firstname,
                  };
                  FirestoreHelper().updateUser(myUser.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),


        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                    hintText: myUser.lastname,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onChanged: (newValue){
                  setState(() {
                    myUser.lastname = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "LASTNAME": myUser.lastname,
                  };
                  FirestoreHelper().updateUser(myUser.uid, map);
                },

                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Text(myUser.email)
      ],
    );
  }
}