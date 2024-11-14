import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/new_chat_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewChatController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Chat Baru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Constants.colorBlack,
          ),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            controller.porsesEncryptDecrypt();
          },
          child: const Text(
            'Coba',
          ),
        ),
      ),
    );
  }
}
