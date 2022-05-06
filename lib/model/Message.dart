import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String idMessage="";
  String from="";
  String to="";
  String text="";
  DateTime sendMessage= DateTime.now();

  Message(DocumentSnapshot snapshot) {
    idMessage = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    from = map['from'];
    to = map['to'];
    text = map['text'];
    Timestamp timestamp = map["sendMessage"];
    sendMessage = timestamp.toDate();
  }
}