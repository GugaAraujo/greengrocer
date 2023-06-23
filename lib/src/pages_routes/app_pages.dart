import 'package:get/get.dart';
import 'package:hello_world/src/pages/base/base_screen.dart';
import 'package:hello_world/src/pages/product/product_screen.dart';
import 'package:hello_world/src/pages/splash/splash_screen.dart';
import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sign_up_screen.dart';
import '../pages/base/binding/navigation_binding.dart';
import '../pages/home/binding/home_binding.dart';
import '../pages/cart/binding/cart_binding.dart';
import '../pages/orders/binding/orders_binding.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.productRoute,
      page: () => ProdcutScreen(),
    ),
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name:  PagesRoutes.signInRoute,
      page: () => SignInScreen()
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen()
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ]
    ),
  ];
}

abstract class PagesRoutes {
  static const productRoute = '/product';
  static const signInRoute = '/signin';
  static const signUpRoute = '/signup';
  static const splashRoute = '/splash';
  static const baseRoute = '/';
}
