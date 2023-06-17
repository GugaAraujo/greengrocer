
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get parseApplicationId => dotenv.env['PARSE_APPLICATION_ID'] ?? '';
  static String get parseRestApiKey => dotenv.env['PARSE_REST_API_KEY'] ?? '';
}
