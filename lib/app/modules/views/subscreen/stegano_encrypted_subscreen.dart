import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/stegano_encrypted_controller.dart';

import '../../../utils/constants.dart';

class SteganoEncryptedSubScreen extends StatelessWidget {
  const SteganoEncryptedSubScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  Widget _gapHorizontal({required double gap}){
    return SizedBox(width: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final SteganoEncryptedController controller = Get.find();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListView(
          shrinkWrap: true,
          children: [
            ElevatedButton(
              onPressed: (){
                controller.pickHostImage();
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
              if(controller.isAnyResultHost.value){
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
                          controller.isAnyResultSecret.value = false;
                          controller.resultSecret = null;
                          controller.messageController.clear();
                        }
                      },
                    ),
                    _gapVertical(gap: 10),
                    controller.selectedItem.value.isEmpty
                        ? const SizedBox()
                        : controller.selectedItem.value == 'Text'
                        ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pesan yang akan disembunyikan :',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Constants.colorBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: controller.messageController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Pesan',
                            hintText: 'Masukkan Pesan',
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _gapVertical(gap: 20),
                        ElevatedButton(
                          onPressed: (){
                            controller.processEncryptedText();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.colorGreen,
                          ),
                          child: Text(
                            'Proses Enkripsi Steganograph',
                            style: TextStyle(
                              color: Constants.colorWhite,
                            ),
                          ),
                        ),
                      ],
                    )
                        :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            controller.pickHiddenImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.colorGreen,
                          ),
                          child: Text(
                            'Cari Image Child',
                            style: TextStyle(
                              color: Constants.colorWhite,
                            ),
                          ),
                        ),
                        _gapVertical(gap: 20),
                        ElevatedButton(
                          onPressed: (){
                            controller.processEncryptedImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.colorGreen,
                          ),
                          child: Text(
                            'Proses Enkripsi Steganograph',
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
