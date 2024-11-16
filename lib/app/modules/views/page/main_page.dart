import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/file_screen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/stegano_screen.dart';
import 'package:tugas_akhir_kripto/app/modules/views/screen/chat_screen.dart';

import '../../../utils/constants.dart';
import '../../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();
    final listPage = [
      const ChatScreen(),
      const FileScreen(),
      const SteganoScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.userName,
          style: TextStyle(
            fontSize: 12,
            color: Constants.colorBlack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              controller.toNotification();
            },
            icon: const Icon(
              Icons.notifications_none,
              size: 24,
            ),
          ),
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
      floatingActionButton: Obx((){
        return controller.currentIndex.value == 0 ?
            FloatingActionButton(
              onPressed: (){
                controller.toNewChat();
              },
              backgroundColor: Constants.colorGreen,
              child: Icon(
                Icons.add,
                color: Constants.colorWhite,
              ),
            )
            : const SizedBox();
      }),
      bottomNavigationBar: Obx(() =>
          BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Constants.colorGreen,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_rounded),
                label: 'Chat',
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
