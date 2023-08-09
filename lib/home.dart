import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:botai/openAI_service.dart';
import 'package:botai/pallete.dart';
import 'package:botai/secrets.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/animation.dart';
import 'featurebox.dart';
import 'chat_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final speechToText = SpeechToText();
  //final String prompt="what is 2+3";

// Future<String> chatGPTAPI() async {
//   try {
//     http.Response res = await http.post(
//       Uri.parse('https://api.openai.com/v1/chat/completions'),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $openAiApiKey"
//       },
//       body: jsonEncode({
//         "model": "gpt-3.5-turbo",
//         "messages": [
//           {
//             "role": "user",
//             "content": "what is 2+3"
//           }
//         ],
//         "temperature": 0.7
//       }),
//     );

//     String content = jsonDecode(res.body)['choices'][0]['message']['content'];
//     content = content.trim();
//     print(content);
//     return content;
//   } catch (e) {
//     print("Error occurred:");
//     print(e.toString());
//     return e.toString();
//   }
// }

  String lastWords = '';
  String? generatedContent;
  String? generatedUrl;
  TextEditingController searchController=new TextEditingController();
  int currentTab=0;
  chatScreen chattingScreen = new chatScreen();
  
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    bool isAvailable = await speechToText.initialize();
    if (isAvailable) {
      await speechToText.listen(
          //listenFor: Duration(seconds: 10),
          onResult: (result) {
            setState(() {
              lastWords = result.recognizedWords;
              print(jsonEncode(lastWords));
                            
            });
            
          });
    }
  }

  Future<void> stopListening() async {
    await speechToText.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "botAI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.menu),
      ),
  //     floatingActionButton:FloatingActionButton( //Floating action button on Scaffold
  //     onPressed: (){
  //         //code to execute on button press
  //     },
  //     child: Icon(Icons.send), //icon inside button
  // ),

  //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

  //floating action button position to right


  // bottomNavigationBar: BottomAppBar(
  //   shape: const CircularNotchedRectangle(),
  //   notchMargin: 10,
  //   child: SizedBox(
  //     height: 60,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [Text("Lenden")],
  //         ),
          
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Material(
  //               child: Center(
  //                 child: InkWell(
  //                     focusColor: Colors.transparent,
  //                     hoverColor: Colors.transparent,
  //                     highlightColor: Colors.transparent,
  //                     onTap: () {
  //                       setState(() {
  //                         currentTab = 2;
  //                       });
  //                     },
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(Icons.checklist_outlined),
  //                         Text("Completed"),
  //                         //const Padding(padding: EdgeInsets.only(right: 10))
  //                       ],
  //                     )),
  //               ),
  //             ),
  //             Material(
  //               child: Center(
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   onTap: () {
  //                     setState(() {
  //                       currentTab = 3;
  //                     });
  //                   },
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(Icons.person),
  //                       Text("Profile")
  //                       //const Padding(padding: EdgeInsets.only(left: 10))
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ),
  // ),

  // bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
  //   color:Colors.transparent,
  //   shape: CircularNotchedRectangle(), //shape of notch
  //   notchMargin: 5, //notche margin between floating button and bottom appbar
  //   child: Container(
  //               margin: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(24),
  //                 color: Colors.greenAccent,
  //               ),
  //               child: Row(
  //                 children: [
  //                   GestureDetector(
  //                       onTap: () {
  //                         print(searchController.text);
  //                         /* Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => Loading(),
  //                                 settings: RouteSettings(
  //                                     arguments: {searchController.text})));
  //                       }*/
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
  //                         child: Icon(Icons.search),
  //                       )),
  //                   Expanded(
  //                     child: TextField(
  //                       controller: searchController,
  //                       obscureText: false,
  //                       decoration: InputDecoration(
  //                         border: InputBorder.none,
  //                         hintText: "Search ",
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  // ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle),
              ),
            ),
            Center(
              child: Container(
                height: 129,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png')),
                ),
              ),
            )
          ]),
          Container(
            width: 260,
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                generatedContent==null ? "Good Morning, what task can i do for you?": generatedContent.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Pallete.mainFontColor),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                    bottomRight: Radius.circular(13))),
          ),

          Container(margin: EdgeInsets.all(20),child: generatedUrl==null? Text(""):Stack(children: [CircularProgressIndicator(),Image.network(generatedUrl.toString())]),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),),

          Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              width: 270,
              child: Text("Here are a few commands",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'jhakas',
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.9)))),
          Column(
            children: [
              featurebox(
                  'ChatGPT',
                  'A smarter way to stay organised and informed with ChatGPT',
                  'first'),
              SizedBox(
                height: 20,
              ),
              featurebox(
                  'DALL-E',
                  'Get inspired and stay creative with your personal assistant powered by DALL-E',
                  'second'),
              SizedBox(height: 20),
              featurebox(
                  'Smart Voice Assistant',
                  'Get the best of both worlds with a voice assistant powered by ChatGPT and DALL-E',
                  'third')
            ],
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAI_service().isImgPrompt(lastWords);
            if(speech.contains('https')){
              generatedUrl=speech;
            }else{generatedContent=speech;}
            print(speech);
            await stopListening();
            setState(() {
              
            });
          } else {
            await initSpeechToText();
          }
  
        },
        child: Icon(Icons.mic),
        enableFeedback: true,
      ),
    );
  }
}
