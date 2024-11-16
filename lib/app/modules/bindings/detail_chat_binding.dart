import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/detail_chat_controller.dart';

class DetailChatBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DetailChatController());
  }

}