import 'package:get/get.dart';
import 'package:hello_world/src/models/order_model.dart';
import 'package:hello_world/src/pages/auth/controller/auth_controller.dart';
import 'package:hello_world/src/pages/orders/repository/orders_repository.dart';
import 'package:hello_world/src/pages/orders/result/orders_result.dart';
import 'package:hello_world/src/services/utils_services.dart';

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
