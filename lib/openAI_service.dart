import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'secrets.dart';
import 'package:http/http.dart' as http;

class openAI_service {
  final openAiApiKey = dotenv.env['openAiApiKey'];
  List<Map<String,String>> messages = [];
  Future<dynamic> isImgPrompt(String prompt) async {
    try {
      http.Response res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $openAiApiKey"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does the following message- $prompt, wants to generate an picture,image,art or anything similar? . simply answer with a yes or no"
              }
            ],
          }));
      print(prompt);
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        print(content);
        switch (content) {
          case "yes": 
          case "YES":
          case "yes.":
          case "YES.":
          case "Yes":
          case "Yes.":
            final res = await dalleAPI(prompt);
            print(res);
            return res;
          default:
            final res = dalleAPI(prompt);
            print(res);
            return res;
        }
      }
    } catch (e) {
      return e.toString();
    }
    // return cont;
  }

Future<String> chatGPTAPI(String prompt) async {
  try {
    http.Response res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $openAiApiKey"
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": prompt
          }
        ],
        "temperature": 0.7
      }),
    );

    String content = jsonDecode(res.body)['choices'][0]['message']['content'];
    content = content.trim();
    print(content);
    return content;
  } catch (e) {
    print("Error occurred:");
    print(e.toString());
    return e.toString();
  }
}


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
    "n": 1,
    "size": "1024x1024"
      }),
    );

    String imageURL = jsonDecode(res.body)['data'][0]['url'];
    print(imageURL);
    return imageURL;
  } catch (e) {
    print("Error occurred:");
    print(e.toString());
    return e.toString();
  }
}
}