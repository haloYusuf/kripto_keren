import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/new_chat_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewChatController controller = Get.find();

    Widget _gapVertical({required double gap}){
      return SizedBox(height: gap,);
    }

    Widget _gapHorizontal({required double gap}){
      return SizedBox(width: gap,);
    }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.usernameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Cari Username',
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  _gapHorizontal(gap: 10),
                  IconButton(
                    onPressed: (){},
                    style: IconButton.styleFrom(
                      backgroundColor: Constants.colorGreen,
                    ),
                    icon: Icon(
                      Icons.search,
                      size: 24,
                      color: Constants.colorWhite,
                    ),
                  ),
                ],
              ),
              _gapVertical(gap: 20),
              Container(
                height: 0.5,
                color: Constants.colorBlack,
              ),
              _gapVertical(gap: 20),
              Text(
                'AES Encryption Set-up : ',
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
              _gapVertical(gap: 10),
              Text(
                'Vigenere Encryption Set-up : ',
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.colorBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _gapVertical(gap: 5),
              TextField(
                controller: controller.vigenereKeyController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  labelText: 'Vigenere Key',
                  hintText: 'Masukkan Vigenere Key',
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
                  border: OutlineInputBorder(),
                ),
              ),
              _gapVertical(gap: 20),
              ElevatedButton(
                onPressed: (){
                  controller.sendProcess();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.colorGreen,
                ),
                child: Text(
                  'Proses',
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.colorWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
