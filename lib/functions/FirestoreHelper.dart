import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chatipssi/model/Users.dart';
import 'package:flutter/cupertino.dart';

class FirestoreHelper {

  //Attributes
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final fireUser = FirebaseFirestore.instance.collection("Users");
  final fire_message = FirebaseFirestore.instance.collection("Message");
  final fire_conversation=FirebaseFirestore.instance.collection('Conversations');

  //Methods

  sendMessage(String text,Users user,Users moi){
    DateTime date=DateTime.now();
    Map <String,dynamic>map={
      'from':moi.uid,
      'to':user.uid,
      'text':text,
      'sendMessage':date
  };
    String idDate = date.microsecondsSinceEpoch.toString();
    addMessage(
        map,
        getMessageRef(moi.uid, user.uid, idDate)
    );
    addConversation(
        getConversation(moi.uid, user, text, date),
        moi.uid
    );
  }

  addMessage(Map<String,dynamic> map,String uid){
    fire_message.doc(uid).set(map);

  }

  addConversation(Map<String,dynamic> map,String uid){
    fire_conversation.doc(uid).set(map);

  }

  Map <String,dynamic> getConversation(String sender,Users partenaire,String text,DateTime date){
    Map <String,dynamic> map = partenaire.toMap();
    map ['idmoi']=sender;
    map['lastmessage']=text;
    map['envoimessage']=date;
    map['destinateur']=partenaire.uid;
    return map;
  }

  String getMessageRef(String from,String to,String date){
    String resultat="";
    List<String> liste=[from,to];
    liste.sort((a,b)=>a.compareTo(b));
    for(var x in liste){
      resultat += x+"+";
    }
    resultat =resultat + date;
    return resultat;
  }













  // Inscription user
  Future <Users> registration(String firstname , String lastname , String mail , String password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    String uid = result.user!.uid;
    Map<String,dynamic> map = {
      "FIRSTNAME" : firstname,
      "LASTNAME" : lastname,
      "EMAIL": mail,
      "CREATED_AT" : DateTime.now(),
      "IS_CONNECTED": true,
    };
    addUser(uid, map);
    return getUsers(uid);
  }



  // login user
  Future <Users> login( String mail , String password) async {
    UserCredential result = await auth.signInWithEmailAndPassword(email: mail, password: password);
    String uid = result.user!.uid;
    return getUsers(uid);
  }

  //Get current user connected
  String getCurrentUserId(){
    return auth.currentUser!.uid;
  }

  //Create class profile
  Future <Users> getUsers(String uid) async {
    DocumentSnapshot snapshot = await fireUser.doc(uid).get();
    return Users(snapshot);
  }

  //create user
  addUser(String uid , Map<String,dynamic> map){
    fireUser.doc(uid).set(map);
  }


  //update user
  updateUser(String uid , Map<String,dynamic> map){
    fireUser.doc(uid).update(map);
  }


  //Stock image
  Future <String> storageFile(String nameFile,Uint8List data) async{
    late String urlPath;
    late TaskSnapshot fireStore;
    fireStore = await  storage.ref("images/$nameFile").putData(data);
    urlPath = await fireStore.ref.getDownloadURL();
    return urlPath;
  }

}