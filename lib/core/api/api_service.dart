import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      "https://civilization-api-production.up.railway.app";

  Future<List<dynamic>> getData(
      String endpoint) async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl$endpoint",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "Failed to load data",
    );
  }
}