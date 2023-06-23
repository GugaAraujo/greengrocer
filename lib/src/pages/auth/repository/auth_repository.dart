import 'package:hello_world/src/constants/endpoints.dart';
import 'package:hello_world/src/models/user_model.dart';
import 'package:hello_world/src/pages/auth/repository/auth_erros.dart'
    as authErrors;
import 'package:hello_world/src/pages/auth/result/auth_result.dart';
import 'package:hello_world/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.changePassword,
      method: HttpMethods.post,
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      headers: {'X-Parse-Session-Token': token}
    );

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: Endpoint.validateToken,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager
        .restRequest(url: Endpoint.signIn, method: HttpMethods.post, body: {
      'email': email,
      'password': password,
    });

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.signUp,
      method: HttpMethods.post,
      body: user.toJson(),
    );
    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoint.resetPassword,
      method: HttpMethods.post,
      body: {'email': email},
    );
  }
}
