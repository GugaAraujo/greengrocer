import 'package:get/get.dart';

import '../../../pages_routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
     Get.toNamed(PagesRoutes.baseRoute);
  }
}