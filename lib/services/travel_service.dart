import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travel_model.dart';

class ApiService {
  // 🔥 PENTING (EMULATOR)
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<List<Travel>> getTravels() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/travel"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load data");
    }
  }
}