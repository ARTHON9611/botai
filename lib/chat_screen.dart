import 'package:botai/openAI_service.dart';
import 'package:botai/sideMenuBar.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  final List messages;
  const chatScreen({required this.messages});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    TextEditingController promptController =new TextEditingController();
   
  
  
  @override
  Widget build(BuildContext context) {
    
    String pos="";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        
        title: const Text(
          "botAI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(onTap: (){_drawerKey.currentState!.openDrawer();},child: const Icon(Icons.menu)),
      ),
      key: _drawerKey,
      endDrawerEnableOpenDragGesture: true,
      drawer: sideMenu(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(child: Icon(Icons.delete),onPressed:()async{
            widget.messages.clear();
            setState(() {
          });},),
         
          SizedBox(height: 10,),
           FloatingActionButton(child: Icon(Icons.send),onPressed:()async{
            final speech = await openAI_service().chatGPTAPI(promptController.text);
                widget.messages.add({'user':promptController.text,'assistant':speech});
            setState(() {
            print(widget.messages);
          });},),
          
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(shrinkWrap: true,itemCount: widget.messages.length,itemBuilder: (context,index){
                return Container(
                  width: 50,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end,children: [Container(margin: EdgeInsets.all(5),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)),child: Expanded(child: Text(widget.messages[index]['user'].toString(),style: TextStyle(fontSize: 15,overflow: TextOverflow.clip),)))],),
                      Row(mainAxisAlignment: MainAxisAlignment.start,children: [Flexible(child: Container(margin: EdgeInsets.only(right: 75,left: 5),padding: EdgeInsets.all(5),decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),child: Flexible(child: Text(widget.messages[index]['assistant'],maxLines: 8,style: TextStyle(fontSize: 15),overflow: TextOverflow.fade,)),))],),
                    ],
                  ),
                );
              }),
  

            ],
            
          ),
        ),
        
      ),
      bottomSheet: BottomSheet(enableDrag: false,onClosing: (){}, builder:(context)=>Container(padding: EdgeInsets.all(10),height: 60,child: TextField(textInputAction: TextInputAction.search,onSubmitted: 
      
      (String prompt)async{
        final speech = await openAI_service().chatGPTAPI(prompt);
            widget.messages.add({'user':promptController.text,'assistant':speech});
        setState(() {
        print(widget.messages);
      });}
      
      
      
      ,controller: promptController,decoration: InputDecoration(hintText: "Enter the prompt",border: InputBorder.none),))),
    );
  }
}