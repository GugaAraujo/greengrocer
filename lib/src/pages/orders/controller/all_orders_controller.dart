import 'package:get/get.dart';

import '../../../models/order_model.dart';
import '../../../services/utils_services.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/orders_repository.dart';
import '../result/orders_result.dart';
class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onReady() {
    super.onReady();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.GetAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
