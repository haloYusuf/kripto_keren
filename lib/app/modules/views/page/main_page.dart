import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/file_screen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/stegano_screen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/text_screen.dart';

import '../../../utils/constants.dart';
import '../../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final listPage = [
      const TextScreen(),
      const FileScreen(),
      const SteganoScreen(),
    ];
    return Scaffold(
      body: Obx(() =>
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                30,
                20,
                0,
              ),
              child: listPage[mainController.currentIndex.value],
            ),
          ),
      ),
      bottomNavigationBar: Obx(() =>
          BottomNavigationBar(
            currentIndex: mainController.currentIndex.value,
            onTap: mainController.changePage,
            selectedItemColor: Constants.colorGreen,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_rounded),
                label: 'Text',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_copy_rounded),
                label: 'File',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_rounded),
                label: 'Steganograph',
              ),
            ],
          ),
      ),
    );
  }
}
