import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travel_model.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<List<Travel>> getTravels() async {
    final response = await http.get(Uri.parse("$baseUrl/travel"));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load data");
    }
  }
}