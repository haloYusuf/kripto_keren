import 'package:get/get.dart';

import '../../utils/aes_helper.dart';
import '../../utils/vigenere_cipher.dart';

class NewChatController extends GetxController{

  void porsesEncryptDecrypt(){
    const aesKey = 'my16charsecret!!'; // Kunci harus 16 karakter untuk AES-128
    const aesIV = 'my16byteivvector'; // IV harus 16 karakter
    final aesHelper = AESHelper(keyString: aesKey, ivString: aesIV);

    // Inisialisasi kunci untuk Vigenere
    const vigenereKey = 'test123solo?!';
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