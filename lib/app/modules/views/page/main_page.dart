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
    final MainController controller = Get.find();
    final listPage = [
      const TextScreen(),
      const FileScreen(),
      const SteganoScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yusuf Arrafi',
          style: TextStyle(
            fontSize: 12,
            color: Constants.colorBlack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              controller.logOut();
            },
            icon: const Icon(
              Icons.logout,
              size: 24,
            ),
          ),
        ],
      ),
      body: Obx(() =>
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                30,
                20,
                0,
              ),
              child: listPage[controller.currentIndex.value],
            ),
          ),
      ),
      bottomNavigationBar: Obx(() =>
          BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
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
