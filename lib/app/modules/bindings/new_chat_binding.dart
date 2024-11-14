import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/new_chat_controller.dart';

class NewChatBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NewChatController());
  }
}