import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/aes_helper.dart';
import '../../utils/vigenere_cipher.dart';

class NewChatController extends GetxController{

  late TextEditingController usernameController;
  late TextEditingController aesKeyController;
  late TextEditingController aesIVController;
  late TextEditingController vigenereKeyController;

  NewChatController(){
    usernameController = TextEditingController();
    aesKeyController = TextEditingController();
    aesIVController = TextEditingController();
    vigenereKeyController = TextEditingController();
  }

  void sendProcess(){
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
      final aesKey = aesKeyController.text;
      final aesIV = aesIVController.text;
      final aesHelper = AESHelper(keyString: aesKey, ivString: aesIV);

      final vigenereKey = vigenereKeyController.text;
      final vigenere = VigenereCipher();

      const plainText = 'halo semua, perkenalkan namaku salma hanifa, saya umur 20 tahun lho!!! Senang berkenalan dengan anda, nama anda siapa?';

      print('Teks Asli: $plainText');

      // Enkripsi Vigenere
      final vigenereEncrypted = vigenere.encrypt(plainText, vigenereKey);
      print('Hasil Enkripsi Vigenere: $vigenereEncrypted');

      // Enkripsi AES-128
      final aesEncrypted = aesHelper.encrypt(vigenereEncrypted);
      print('Hasil Enkripsi AES: $aesEncrypted');

      // Dekripsi AES-128
      final aesDecrypted = aesHelper.decrypt(aesEncrypted);
      print('Hasil Dekripsi AES: $aesDecrypted');

      // Dekripsi Vigenere
      final vigenereDecrypted = vigenere.decrypt(aesDecrypted, vigenereKey);
      print('Teks yang di-dekripsi: $vigenereDecrypted');
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