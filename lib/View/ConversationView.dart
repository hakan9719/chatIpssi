import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatipssi/functions/FirestoreHelper.dart';
import 'package:chatipssi/model/Users.dart';
import 'package:chatipssi/View/ZoneText.dart';
import 'package:chatipssi/library/lib.dart';
import 'package:chatipssi/Controller/Message.dart';

class ConversationView extends StatefulWidget{
  Users partenaire;
  Users moi;
  ConversationView({Key? key,required Users this.partenaire, required Users this.moi}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConversationViewState();
  }
}

class ConversationViewState extends State<ConversationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.partenaire.firstname) ,
            Text(" "),
            Text(widget.partenaire.lastname) ,
          ],
        )
      ),
        body: Stack(
          children: [
              MessageController(id:widget.moi, idPartner:widget.partenaire),
            //ZoneText(partenaire:widget.partenaire, moi:widget.moi)
          ],
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          child: ZoneText(partenaire:widget.partenaire, moi:widget.moi),
        )
    );
  }

  Widget bodyPage() {
    return Column(
      children: [
        MessageController(id:widget.moi, idPartner:widget.partenaire),
        ZoneText(partenaire:widget.partenaire, moi:widget.moi),
      ],
    );
  }
}