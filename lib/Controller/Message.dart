import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatipssi/model/Users.dart';
import 'package:chatipssi/model/Message.dart';
import 'package:chatipssi/View/MessageBubble.dart';
import 'package:chatipssi/functions/FirestoreHelper.dart';

class MessageController extends StatefulWidget{
  Users id;
  Users idPartner;
  MessageController({Key? key,required Users this.id, required Users this.idPartner}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessageControllerState();
  }

}

class MessageControllerState extends State<MessageController> {
  late Animation animation;
  late AnimationController controller;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fire_message.orderBy('sendMessage',descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }else {
          List<DocumentSnapshot>documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context,int index){
                Message discussion = Message(documents[index]);
                if((discussion.from==widget.id.uid && discussion.to==widget.idPartner.uid)||
                    (discussion.from==widget.idPartner.uid && discussion.to==widget.id.uid)) {
                  return messageBubble(monId:widget.id.uid, partenaire:widget.idPartner, message:discussion,);
                }else{
                  return Container();
                }
              },
          );
        }
      }
    );
  }
}