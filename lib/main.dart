import 'package:chatipssi/Controller/Login.dart';
import 'package:chatipssi/Controller/Registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Project Ipssi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Chat Project Ipssi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mail="";
  String password="";
  String firstname="";
  String lastname="";
  List<bool> selections = [true,false];
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child : Stack(
            children: [
              //Wallpaper(),
              bodyPage(),
            ],
          ),
        ),
    );
  }

  Widget bodyPage(){
    return Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Inscription"),
              Switch(value: selected, onChanged: (value){
                setState(() {
                  selected = value;
                });
              }),
              const Text("Connexion"),
            ],
          ),
          const SizedBox(height: 20,),
          (selected)?Login():Registration(),
        ]
    );
  }

}
