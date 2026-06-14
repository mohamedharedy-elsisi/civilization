import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiService {

  static const String apiKey =
      "AQ.Ab8RN6IFAo3AsWgi5rWwtA1EZcO6rm-tZcGhJVTpl4oX7We-xA";

  Future<String> askQuestion(
      String question) async {

    try {

      final response =
      await http.post(

        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
        ),

        headers: {
          "Content-Type":
          "application/json",
        },

        body: jsonEncode({

          "contents": [

            {

              "parts": [

                {
                  "text":
                  '''
You are an assistant specialized in Ancient Egyptian Civilization.

Answer only questions related to:
- Pharaohs
- Temples
- Museums
- Statues
- Obelisks
- Ancient Egypt

Question:
$question
'''
                }

              ]

            }

          ]

        }),
      );

      if (response.statusCode == 200) {

        final data =
        jsonDecode(response.body);

        return data["candidates"][0]
        ["content"]["parts"][0]
        ["text"];
      }

      return "Error: ${response.body}";

    } catch (e) {

      return "Error: $e";
    }
  }
}