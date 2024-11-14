import 'package:encrypt/encrypt.dart';

class AESHelper{
  late final Key key;
  late final IV iv;

  AESHelper({
    required String keyString,
    required String ivString,
  }) {
    key = Key.fromUtf8(keyString);
    iv = IV.fromUtf8(ivString);
  }

  // Enkripsi dengan AES
  String encrypt(String plainText) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  // Dekripsi dengan AES
  String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

}