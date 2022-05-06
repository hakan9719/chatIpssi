import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  late String _uid;
  late DateTime createdAt;
  late String lastname;
  late String firstname;
  late String email;
  String? avatar;
  DateTime? birthdate;

  String get uid {
    return _uid;
  }

  //Constructor
  Users(DocumentSnapshot snapshot){
    _uid = snapshot.id;
    Map <String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    Timestamp timestamp = map["CREATED_AT"];
    createdAt = timestamp.toDate();
    lastname = map["LASTNAME"];
    firstname = map["FIRSTNAME"];
    avatar = map["IMAGE"];
    Timestamp? timpestamp2 = map["BIRTHDATE"];
    birthdate = timpestamp2?.toDate();
    email = map["EMAIL"];
  }

//Methods
  Map<String,dynamic> toMap(){
    Map <String,dynamic> map;
    return map ={
      'LASTNAME':lastname,
      'FIRSTNAME':firstname,
      'IMAGE':avatar,
      'EMAIL':email,
      'BIRTHDATE':birthdate,
    };
  }
}