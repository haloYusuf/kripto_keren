import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

import '../../routes/route_name.dart';

class SplashController extends GetxController{
  var opacity = 0.0.obs;
  final box = GetStorage();
  final _isLogin = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _isLogin.value = box.read(Constants.dataIsLogin) ?? false;
    showSplash();
  }

  void showSplash(){
    Timer(const Duration(milliseconds: 500), () {
      opacity.value = 1.0;
    });

    Timer(const Duration(milliseconds: 2000), () {
      if(_isLogin.value){
        Get.offAllNamed(RouteName.main);
      }else{
        Get.offAllNamed(RouteName.login);
      }
    });
  }
}