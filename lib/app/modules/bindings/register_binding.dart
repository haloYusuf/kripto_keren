import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RegisterController());
  }
}