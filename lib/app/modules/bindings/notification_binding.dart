import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NotificationController());
  }

}