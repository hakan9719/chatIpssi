import 'package:flutter/material.dart';
import 'package:chatipssi/View/ChatView.dart';
import 'package:chatipssi/View/ProfilView.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  int selected = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (newValue){
          setState(() {
            selected = newValue;
            controller.jumpToPage(newValue);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Chat"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label : "Profile"
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return PageView(
      onPageChanged: (value){
        setState(() {
          selected = value;
        });
      },
      children: const [
        ChatView(),
        ProfilView(),
      ],
      controller: controller,
    );
  }
}