import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/chat_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/file_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/file_decrypted_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/file_encrypted_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_decrypted_controller.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_encrypted_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => FileController());
    Get.lazyPut(() => SteganoController());
    Get.lazyPut(() => FileEncryptedController());
    Get.lazyPut(() => FileDecryptedController());
    Get.lazyPut(() => SteganoEncryptedController());
    Get.lazyPut(() => SteganoDecryptedController());
  }
}