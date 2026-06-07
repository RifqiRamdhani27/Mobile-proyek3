import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travel_model.dart';

class ApiService {
  static const String baseUrl = 'https://ravola-travel.wuaze.com';

  static Future<List<Travel>> getTravels({String? search}) async {
    final uri = Uri.parse("$baseUrl/travel").replace(
        queryParameters: search != null && search.isNotEmpty ? {'search': search} : null);

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*', // tambah ini
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load data");
    }
  }
}