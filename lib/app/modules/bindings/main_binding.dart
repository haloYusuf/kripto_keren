import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/chat_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => ChatController());
  }
}