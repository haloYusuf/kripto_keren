import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tugas_akhir_kripto/app/modules/bindings/login_binding.dart';
import 'package:tugas_akhir_kripto/app/modules/bindings/new_chat_binding.dart';
import 'package:tugas_akhir_kripto/app/modules/bindings/register_binding.dart';
import 'package:tugas_akhir_kripto/app/modules/views/page/login_page.dart';
import 'package:tugas_akhir_kripto/app/modules/views/page/new_chat_page.dart';
import 'package:tugas_akhir_kripto/app/modules/views/page/register_page.dart';
import 'package:tugas_akhir_kripto/app/routes/route_name.dart';

import '../modules/bindings/main_binding.dart';
import '../modules/bindings/splash_binding.dart';
import '../modules/views/page/main_page.dart';
import '../modules/views/page/splash_page.dart';

class RoutePage{
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteName.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteName.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteName.main,
      page: () => const MainPage(),
      binding: MainBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteName.newChat,
      page: () => const NewChatPage(),
      binding: NewChatBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}