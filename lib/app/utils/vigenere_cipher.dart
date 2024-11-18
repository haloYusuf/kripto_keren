import 'dart:convert';

class VigenereCipher {

  String encrypt(String text, String key) {
    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < text.length; i++) {
      int textChar = text.codeUnitAt(i);
      int keyChar = key.codeUnitAt(i % keyLength);

      int encryptedChar = (textChar + keyChar) % 256;
      result += String.fromCharCode(encryptedChar);
    }

    return base64Encode(utf8.encode(result));
  }

  String decrypt(String encryptedText, String key) {
    String decodedText = utf8.decode(base64Decode(encryptedText));

    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < decodedText.length; i++) {
      int encryptedChar = decodedText.codeUnitAt(i);
      int keyChar = key.codeUnitAt(i % keyLength);

      int decryptedChar = (encryptedChar - keyChar + 256) % 256;
      result += String.fromCharCode(decryptedChar);
    }
    return result;
  }
}