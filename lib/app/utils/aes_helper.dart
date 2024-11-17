import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class AESHelper{
  late final Key key;
  late final IV iv;
  late Encrypter encrypter;

  AESHelper({
    required String keyString,
    required String ivString,
  }) {
    key = Key.fromUtf8(keyString);
    iv = IV.fromUtf8(ivString);
    encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  }

  // Enkripsi dengan AES
  String encrypt(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  // Dekripsi dengan AES
  String decrypt(String encryptedText) {
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

  // Enkripsi dengan AES
  Uint8List encryptFile(Uint8List plainBytes) {
    return encrypter.encryptBytes(plainBytes, iv: iv).bytes;
  }

  // Dekripsi dengan AES
  List<int> decryptFile(Uint8List encryptedBytes) {
    return encrypter.decryptBytes(Encrypted(encryptedBytes), iv: iv);
  }

}