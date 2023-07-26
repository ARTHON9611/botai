import 'dart:convert';
import 'secrets.dart';
import 'package:http/http.dart' as http;

class openAI_service {
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
            "temperature": 0.7
          }));
      print(prompt);
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['messages']['content'];
        content = content.trim();
        print(content);
        switch (content) {
          case "yes":
          case "YES":
          case "yes.":
          case "YES.":
          case "Yes":
          case "Yes.":
            final res = await dalleAPI();
            print(res);
            return res;
          default:
            final res = chatGPTAPI();
            print(res);
            return res;
        }
      }
    } catch (e) {
      return e.toString();
    }
    // return cont;
  }

  String chatGPTAPI() {
    return "chatgpt";
  }

  String dalleAPI() {
    return "dalle";
  }
}
