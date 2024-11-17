import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/services/conversation_service.dart';
import 'package:tugas_akhir_kripto/app/data/services/user_service.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class NewChatController extends GetxController{

  late UserService userService;
  late ConversationService conversationService;

  late TextEditingController usernameController;
  late TextEditingController aesKeyController;
  late TextEditingController aesIVController;
  late TextEditingController vigenereKeyController;

  late GetStorage _box;
  var statusSearch = (-1).obs;
  var targetToken = ''.obs;
  var targetName = ''.obs;
  var errorMessage = ''.obs;


  NewChatController(){
    usernameController = TextEditingController();
    aesKeyController = TextEditingController();
    aesIVController = TextEditingController();
    vigenereKeyController = TextEditingController();

    userService = UserService();
    conversationService = ConversationService();
    _box = GetStorage();
  }

  void searchUser()async{
    if(usernameController.text.isEmpty){
      _showDialog(
        title: 'Gagal',
        message: 'Username tidak boleh kosong.',
      );
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      await userService.getUserToken(
        uName: usernameController.text,
      ).then((value)async{
        Get.back();
        if(value.isEmpty){
          statusSearch.value = 0;
          errorMessage.value = 'Username tidak ditemukan!';
        }else if(value == _box.read(Constants.dataUserToken)){
          statusSearch.value = 1;
          errorMessage.value = 'Tidak boleh memasukkan username anda sendiri!';
        }else{
          await conversationService.isAnyUserInChat(targetToken: value).then((v){
            if(v){
              statusSearch.value = 2;
              errorMessage.value = 'Anda sudah membuat Chat dengan ${usernameController.text}!';
            }else{
              targetToken.value = value;
              targetName.value = usernameController.text;
              statusSearch.value = 5;
            }
          });
        }
      });
    }
  }

  void sendProcess() async{
    final aesKey = aesKeyController.text;
    final aesIV = aesIVController.text;

    final vigenereKey = vigenereKeyController.text;

    if(aesKeyController.text.length != 16){
      _showDialog(
        title: 'Error',
        message: 'Panjang karakter Aes Key harus 16 Karakter.',
      );
    }else if(aesIVController.text.length != 16){
      _showDialog(
        title: 'Error',
        message: 'Panjang karakter Aes IV harus 16 Karakter.',
      );
    }else if(vigenereKeyController.text.isEmpty){
      _showDialog(
        title: 'Error',
        message: 'Vigenere Key tidak boleh kosong.',
      );
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      await conversationService.createNewChat(
        targetToken: targetToken.value,
        targerName: targetName.value,
        aesKey: aesKey,
        aesIV: aesIV,
        vigenereKey: vigenereKey,
      ).then((value){
        Get.back();
        if(value){
          Get.back();
        }else{
          _showDialog(
            title: 'Error',
            message: 'Gagal memproses pesan baru.',
          );
        }
      });
    }
  }

  SnackbarController _showDialog({
    required String title,
    required String message,
  }){
    return Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 1),
    );
  }

}