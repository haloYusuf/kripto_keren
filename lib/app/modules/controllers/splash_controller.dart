import 'dart:async';

import 'package:get/get.dart';

import '../../routes/route_name.dart';

class SplashController extends GetxController{
  var opacity = 0.0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showSplash();
  }

  void showSplash(){
    Timer(const Duration(milliseconds: 500), () {
      opacity.value = 1.0;
    });

    Timer(const Duration(milliseconds: 2000), () {
      Get.offAllNamed(RouteName.main);
    });
  }
}