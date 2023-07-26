import 'dart:convert';

import 'package:botai/openAI_service.dart';
import 'package:botai/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'featurebox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final speechToText = SpeechToText();
  String lastWords = '';
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
  void startListening() async {
    bool isAvailable = await speechToText.initialize();
    if (isAvailable) {
      await speechToText.listen(
          listenFor: Duration(seconds: 10),
          onResult: (result) {
            setState(() {
              lastWords = result.recognizedWords;
              print(jsonEncode(lastWords));
            });
          });
    }
  }

  void stopListening() async {
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
                "Good Morning, what task can i do for you?",
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
            startListening();
          } else if (speechToText.isListening) {
            stopListening();
          } else {
            initSpeechToText();
          }
          openAI_service().isImgPrompt();
        },
        child: Icon(Icons.mic),
        enableFeedback: true,
      ),
    );
  }
}
