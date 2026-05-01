import 'package:flutter_dotenv/flutter_dotenv.dart';

String get BASE_URL => dotenv.env['BASE_URL'] ?? 'http://127.0.0.1:8000';
