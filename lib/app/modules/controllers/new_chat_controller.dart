import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/services/chat_service.dart';
import 'package:tugas_akhir_kripto/app/data/services/user_service.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class NewChatController extends GetxController{

  late UserService userService;
  late ChatService chatService;

  late TextEditingController usernameController;
  late TextEditingController aesKeyController;
  late TextEditingController aesIVController;
  late TextEditingController vigenereKeyController;

  late GetStorage _box;
  var statusSearch = (-1).obs;
  var userToken = ''.obs;
  var errorMessage = ''.obs;


  NewChatController(){
    usernameController = TextEditingController();
    aesKeyController = TextEditingController();
    aesIVController = TextEditingController();
    vigenereKeyController = TextEditingController();

    userService = UserService();
    chatService = ChatService();
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
        }else{
          if(value == _box.read(Constants.dataUserToken)){
            statusSearch.value = 1;
            errorMessage.value = 'Tidak boleh memasukkan username anda sendiri!';
          }else{
            await chatService.isAnyUserInChat(targetToken: value).then((v){
              print(v);
              if(v){
                statusSearch.value = 2;
                errorMessage.value = 'Anda sudah membuat Chat dengan ${usernameController.text}!';
              }else{
                userToken.value = value;
                statusSearch.value = 5;
              }
            });
          }
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
      await chatService.createNewChat(
        targetToken: userToken.value,
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
      // final aesHelper = AESHelper(keyString: aesKey, ivString: aesIV);
      // final vigenere = VigenereCipher();

      // const plainText = 'halo semua, perkenalkan namaku salma hanifa, saya umur 20 tahun lho!!! Senang berkenalan dengan anda, nama anda siapa?';
      //
      // print('Teks Asli: $plainText');
      //
      // // Enkripsi Vigenere
      // final vigenereEncrypted = vigenere.encrypt(plainText, vigenereKey);
      // print('Hasil Enkripsi Vigenere: $vigenereEncrypted');
      //
      // // Enkripsi AES-128
      // final aesEncrypted = aesHelper.encrypt(vigenereEncrypted);
      // print('Hasil Enkripsi AES: $aesEncrypted');
      //
      // // Dekripsi AES-128
      // final aesDecrypted = aesHelper.decrypt(aesEncrypted);
      // print('Hasil Dekripsi AES: $aesDecrypted');
      //
      // // Dekripsi Vigenere
      // final vigenereDecrypted = vigenere.decrypt(aesDecrypted, vigenereKey);
      // print('Teks yang di-dekripsi: $vigenereDecrypted');
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