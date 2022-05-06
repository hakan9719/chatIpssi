import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatipssi/functions/FirestoreHelper.dart';
import 'package:chatipssi/model/Users.dart';
import 'package:chatipssi/View/ConversationView.dart';
import 'package:chatipssi/library/lib.dart';
import 'package:chatipssi/modelView/ImageRond.dart';

class ChatView extends StatefulWidget{
  const ChatView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatViewState();
  }
}

class ChatViewState extends State<ChatView> {
  int selected = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Text(" Chat Ipssi"),
            ],
          )

      ),
        body: bodyPage(),
    );
  }
  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fireUser.snapshots(),
      builder: (context, snapshopt){
        if(!snapshopt.hasData){
          return const CircularProgressIndicator();
        }else{
          List documents = snapshopt.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context,index) {
                Users users = Users(documents[index]);
                if (users.uid == myUser.uid) {
                  return Container();
                } else {
                  return InkWell(
                      child: Card(
                        elevation: 5.0,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          //Image
                          leading: ImageRond(image: users.avatar, size: 60),

                          title: Text("${users.firstname} ${users.lastname}"),
                          subtitle: Text("${users.email}"),
                        ),
                      ),
                      onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ConversationView(moi: myUser, partenaire: users);
                        }
                    ));
                  },
                  );
                }
              }
          );
        }
      },
    );
  }
}