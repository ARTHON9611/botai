import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  List<Map> messages=[];

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(itemCount: widget.messages.length,itemBuilder: (context,index){
          return Row(children: [Container(child: Text(widget.messages[index]['user']),)],);
        })
      ],
    );
  }
}