import 'dart:convert';
import 'package:http/http.dart';

import 'secrets.dart';
import 'package:http/http.dart' as http;

class openAI_service {
  Future<void> isImgPrompt() async {
    Response cont = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAiApiKey"
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": "what is a flutter"}
          ],
          "temperature": 0.7
        }));
    // return cont;
  }
}
