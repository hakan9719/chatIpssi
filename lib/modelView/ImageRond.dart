import 'package:flutter/material.dart';


class ImageRond extends StatefulWidget{
  String? image;
  double? size;
  ImageRond({required this.image, this.size});
  @override
  State<StatefulWidget> createState(){
    //Todo: implement createState
    return ImageRondState();
  }
}

class ImageRondState extends State<ImageRond>{
  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    //Todo: Implement build
    return bodyPage();
  }
  Widget bodyPage(){
    return Container(
      height: widget.size ?? 40,
      width: widget.size ?? 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (widget.image == null)?NetworkImage('https://firebasestorage.googleapis.com/v0/b/chat-project-ipssi.appspot.com/o/notfoundimage.png?alt=media&token=72ad4d90-a5cb-4125-ba8c-94f2088b961d'):NetworkImage(widget.image!),
          fit: BoxFit.fill
        )
      ),
    );
  }
}