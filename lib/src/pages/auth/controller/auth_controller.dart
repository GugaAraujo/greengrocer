import 'package:get/get.dart';
import 'package:hello_world/src/constants/storage_keys.dart';
import 'package:hello_world/src/pages/auth/repository/auth_repository.dart';
import 'package:hello_world/src/pages/auth/result/auth_result.dart';
import 'package:hello_world/src/services/utils_services.dart';

import '../../../models/user_model.dart';
import '../../../pages_routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (message) {
      signOut();
    });
  }

  Future<void> signOut() async {
    this.user = UserModel();
    await utilsServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (error) {
      utilsServices.showToast(message: error, isError: true);
    });
  }

  void saveTokenAndProcedToBase() {
    utilsServices.saveLocalData(key: StorageKeys.token, value: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      saveTokenAndProcedToBase();
    }, error: (error) {
      utilsServices.showToast(message: error, isError: true);
    });
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await authRepository.changePassword(
      token: user.token!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      email: user.email!,
    );

    isLoading.value = false;

    if (result) {
      utilsServices.showToast(message: 'Senha alterada com sucesso');
      signOut();
    } else {
      utilsServices.showToast(
          message: 'A senha atual está incorreta', isError: true);
    }
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
