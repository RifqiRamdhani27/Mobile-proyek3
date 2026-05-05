import 'package:flutter_dotenv/flutter_dotenv.dart';

String get BASE_URL =>
    dotenv.env['BASE_URL'] ?? 'https://ravola-travel.wuaze.com';
String get FLASK_ENGINE_URL =>
    dotenv.env['FLASK_ENGINE_URL'] ?? 'https://ravola.pythonanywhere.com';
