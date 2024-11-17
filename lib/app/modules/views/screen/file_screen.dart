import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/file_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final FileController controller = Get.find();
    return DefaultTabController(
      length: controller.dataView.length,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              labelColor: Constants.colorGreen,
              indicatorColor: Constants.colorGreen,
              tabs: const [
                Tab(text: 'Enkripsi'),
                Tab(text: 'Dekripsi'),
              ],
            ),
            _gapVertical(gap: 10),
            Expanded(
              child: TabBarView(
                children: controller.dataView,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
