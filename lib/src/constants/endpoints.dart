import 'package:hello_world/src/config/environments.dart';

String baseUrl = Environments.apiUrl;

abstract class Endpoint {
  static String signIn = '$baseUrl/login';
  static String signUp = '$baseUrl/signup';
  static String validateToken = '$baseUrl/validate-token';
  static String resetPassword = '$baseUrl/reset-password';
  static String getAllCategories = '$baseUrl/get-category-list';
  static String getAllProducts = '$baseUrl/get-product-list';
  static String getCartItems = '$baseUrl/get-cart-items';
  static String addItemToCart = '$baseUrl/add-item-to-cart';
  static String changeItemQuantity = '$baseUrl/modify-item-quantity';
  static String checkout = '$baseUrl/checkout';
}
