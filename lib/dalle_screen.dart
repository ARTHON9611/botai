import 'dart:convert';

import 'package:botai/colors.dart';
import 'package:botai/sideMenuBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class dalleImg extends StatefulWidget {
  const dalleImg({super.key});

  @override
  State<dalleImg> createState() => _dalleImgState();
}

class _dalleImgState extends State<dalleImg> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List images = [];
    String prompt="apples";
    TextEditingController searchController = new TextEditingController();
    bool isLoading = false;
    
  final openAiApiKey = dotenv.env['openAiApiKey'].toString();

Future<String> dalleAPI(String prompt) async {
  try {
    http.Response res = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $openAiApiKey"
      },
      body: jsonEncode({
  "prompt": prompt,
    "n": 5,
    "size": "1024x1024"
      }),
    );
    print(prompt);

    String imageURL = jsonDecode(res.body)['data'][0]['url'];
    print(imageURL);
    images.add(imageURL);
    return imageURL;
  } catch (e) {
    print("Error occurred:");
    print(e.toString());
    return e.toString();
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        
        title: const Text(
          "botAI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(onTap: (){_drawerKey.currentState?.openDrawer();},child: const Icon(Icons.menu)),
      ),
       key: _drawerKey,
      endDrawerEnableOpenDragGesture: true,
      drawer: sideMenu(),
      body: SafeArea(
        child: Column(children: [Container(
                //Search Wala Container
        
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        isLoading=true;
                        setState(() {
                          
                        });
                        images=[];
                        await dalleAPI(searchController.text);
                        setState(() {
                          isLoading=false;
                          
                        });
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                       
                        onSubmitted: (value) async{
                          isLoading=true;
                          setState(() {
                            
                          });
                           images=[];
                          final imgUrl= await dalleAPI(searchController.text);
                          setState(() {
                            isLoading=false;
                            print(images);
                            
                          });
                          
                        },
                      
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Give prompt"),
                      ),
                    )
                  ],
                )),
                Container(child: isLoading?Lottie.asset("assets/loading.json"):Text(""),)
                ,
          Expanded(
            child: Container(
              child: ListView.builder(shrinkWrap: true,itemCount:images.length ,itemBuilder: (context,index){
                return Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: 
                black,width: 20)),child: Image.network(images[index]),);
              }),
            ),
          )
        ]),
      ),

      // bottomSheet: BottomSheet(enableDrag: false,onClosing: (){}, builder:(context)=>Container(padding: EdgeInsets.all(10),height: 60,child: TextField(textInputAction: TextInputAction.search,onSubmitted: 
      // (String prompt)async{
      //   await gettingdata(promptController.text);
      //   setState(() {
      //   });

      // }
      // ,controller: promptController,decoration: InputDecoration(hintText: "Enter the prompt",border: InputBorder.none),))),
    );
}}