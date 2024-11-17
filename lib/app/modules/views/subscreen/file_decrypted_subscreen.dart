import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/file_decrypted_controller.dart';

import '../../../utils/constants.dart';

class FileDecryptedSubScreen extends StatelessWidget {
  const FileDecryptedSubScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  Widget _gapHorizontal({required double gap}){
    return SizedBox(width: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final FileDecryptedController controller = Get.find();
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
                'Cari File',
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
              if(!controller.isAnyResult.value){
                return const SizedBox();
              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'AES Encryption Set-up : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Constants.colorBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _gapVertical(gap: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.aesKeyController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLength: 16,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Aes Key',
                              hintText: 'Masukkan Aes Key',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        _gapHorizontal(gap: 10),
                        Expanded(
                          child: TextField(
                            controller: controller.aesIVController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLength: 16,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Aes IV',
                              hintText: 'Masukkan Aes IV',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _gapVertical(gap: 20),
                    ElevatedButton(
                      onPressed: (){
                        controller.prosesDekripsi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.colorGreen,
                      ),
                      child: Text(
                        'Enkripsi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Constants.colorWhite,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
