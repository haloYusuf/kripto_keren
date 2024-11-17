import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_controller.dart';

import '../../../utils/constants.dart';

class SteganoScreen extends StatelessWidget {
  const SteganoScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final SteganoController controller = Get.find();
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
