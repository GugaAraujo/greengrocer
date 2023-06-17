import 'package:hello_world/src/config/environments.dart';

String baseUrl = Environments.apiUrl;

abstract class Endpoint {
  static String signIn = '$baseUrl/login';
  static String signUp = '$baseUrl/signup';
  static String validateToken = '$baseUrl/validate-token';
  static String resetPassword = '$baseUrl/reset-password';
}
