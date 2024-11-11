import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
  }
}