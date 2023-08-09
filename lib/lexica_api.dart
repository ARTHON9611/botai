import 'dart:convert';

import 'package:botai/colors.dart';
import 'package:botai/model.dart';
import 'package:botai/openAI_service.dart';
import 'package:botai/sideMenuBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
class lexicaImg extends StatefulWidget {
 lexicaImg({super.key});
  @override
  State<lexicaImg> createState() => _lexicaImgState();
  

}

class _lexicaImgState extends State<lexicaImg> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    List<imgModel> models = [];
    String prompt="apples";
    TextEditingController searchController = new TextEditingController();
    
  final openAiApiKey = dotenv.env['openAiApiKey'].toString();
  bool isLoading=false;
  gettingdata(String prompt) async {
    String api;
      api =
          "https://lexica.art/api/v1/search?q=$prompt";
    Uri url = Uri.parse(api);
    Response response = await get(url);
    Map trash = jsonDecode(response.body);
    print(trash);
    List info = trash["images"];
    print(info.length);
     try {
      for (var element in info) {
        imgModel newsmodel = imgModel();
        newsmodel = imgModel.fromMap(element);
        models.add(newsmodel);
        if (models.length >= 20) {
          break;
        }
      }
    } catch (e) {
      print(e);
    }
    ;
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
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          models=[];
                          await gettingdata("apples");
                           isLoading=false;
                          setState(() {
                           
                            
                            
                          });
                          
                        } else {
                          models=[];
                          await gettingdata(searchController.text);
                          isLoading=false;
                          setState(() {
                            
                            
                            
                          });
                          
                        }
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
                          final speech = await openAI_service().chatGPTAPI("Modify the following prompt - ${searchController.text} to generate ffamily friendly images");
                    
                          switch (speech) { 
                          case "yes": 
                          case "YES":
                          case "yes.":
                          case "YES.":
                          case "Yes":
                          case "Yes.":
                               final prompt = "apples";
                          default:
                               final prompt=speech;

                          if ((prompt).replaceAll(" ", "") == "") {
                          await gettingdata(prompt);
                          models=[];
                          isLoading=false;
                          setState(() {
                            
                            
                          });
                          
                        } else {
                          models=[];
                          await gettingdata(prompt);
                          isLoading=false;
                          setState(() {
      
                            
                          });
                          
                        }
                        }},
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Give prompt"),
                      ),
                    )
                  ],
                )),

                Container(child: isLoading?Lottie.asset("assets/loading2.json"):Text(""),)
                ,
          Expanded(
            child: Container(
              child: ListView.builder(shrinkWrap: true,itemCount:models.length ,itemBuilder: (context,index){
                return Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: 
                black,width: 20)),child: Image.network(models[index].genImg),);
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
  }
}