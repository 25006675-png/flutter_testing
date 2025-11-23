import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  // 1. Private static instance
  static final GeminiService _instance = GeminiService._internal();

  // 2. Public factory to access the instance
  factory GeminiService() {
    return _instance;
  }

  // 3. Internal constructor
  GeminiService._internal();

  // 4. Configuration
  // TODO: Ideally, fetch this from a secure backend or .env file, not hardcoded here.
  final String _apiKey = "AIzaSyB1PV9MEokMWVtP2XRd5njPSlbY5ICZNxk"; 
  final String _model = "gemini-2.5-flash";

  Future<String> sendMessage(String prompt) async {
    final Uri url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$_apiKey",
    );

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "contents": [
        {
          "parts": [{"text": prompt}]
        }
      ]
    });

    try {
      final res = await http.post(url, headers: headers, body: body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        throw Exception("Error ${res.statusCode}: ${res.body}");
      }
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }
}