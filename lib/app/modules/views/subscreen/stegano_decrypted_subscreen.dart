import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_decrypted_controller.dart';

import '../../../utils/constants.dart';

class SteganoDecryptedSubScreen extends StatelessWidget {
  const SteganoDecryptedSubScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final SteganoDecryptedController controller = Get.find();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListView(
          shrinkWrap: true,
          children: [
            ElevatedButton(
              onPressed: (){
                controller.pickFile();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.colorGreen,
              ),
              child: Text(
                'Cari Image Host',
                style: TextStyle(
                  color: Constants.colorWhite,
                ),
              ),
            ),
            _gapVertical(gap: 10),
            Container(
              height: 0.5,
              color: Constants.colorBlack,
            ),
            _gapVertical(gap: 10),
            Obx((){
              if(controller.isAnyResult.value){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButton(
                      value: controller.selectedItem.value.isEmpty ? null : controller.selectedItem.value,
                      hint: const Text('Pilih data yang ingin di samarkan.'),
                      items: controller.items.map((e){
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value){
                        if(value != null){
                          controller.selectedItem.value = value.toString();
                          controller.messageResult.value = '';
                        }
                      },
                    ),
                    controller.selectedItem.value.isEmpty
                        ? const SizedBox()
                        : controller.selectedItem.value == 'Text'
                        ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            controller.processDecryptedText();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.colorGreen,
                          ),
                          child: Text(
                            'Proses Dekripsi Steganograph',
                            style: TextStyle(
                              color: Constants.colorWhite,
                            ),
                          ),
                        ),
                        _gapVertical(gap: 10),
                        controller.messageResult.value.isNotEmpty
                            ? Text('Pesan yang didapat: ${controller.messageResult.value}')
                            : const SizedBox(),
                      ],
                    )
                        :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            controller.processDecryptedImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.colorGreen,
                          ),
                          child: Text(
                            'Proses Dekripsi Steganograph',
                            style: TextStyle(
                              color: Constants.colorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }else{
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
