import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
  }
}