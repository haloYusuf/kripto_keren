import 'dart:convert';

class VigenereCipher {
  // Fungsi untuk mengenkripsi teks menggunakan Vigenere Cipher (rentang ASCII 0-255)
  String encrypt(String text, String key) {
    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < text.length; i++) {
      int textChar = text.codeUnitAt(i); // Karakter teks asli
      int keyChar = key.codeUnitAt(i % keyLength); // Karakter kunci yang berulang

      // Enkripsi karakter menggunakan kode ASCII
      int encryptedChar = (textChar + keyChar) % 256;
      result += String.fromCharCode(encryptedChar);
    }

    // Konversi hasil enkripsi ke Base64 agar lebih mudah dibaca
    return base64Encode(utf8.encode(result));
  }

  // Fungsi untuk mendekripsi teks menggunakan Vigenere Cipher (rentang ASCII 0-255)
  String decrypt(String encryptedText, String key) {
    // Decode dari Base64 ke teks terenkripsi asli
    String decodedText = utf8.decode(base64Decode(encryptedText));

    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < decodedText.length; i++) {
      int encryptedChar = decodedText.codeUnitAt(i); // Karakter terenkripsi
      int keyChar = key.codeUnitAt(i % keyLength); // Karakter kunci yang berulang

      // Dekripsi karakter menggunakan kode ASCII
      int decryptedChar = (encryptedChar - keyChar + 256) % 256;
      result += String.fromCharCode(decryptedChar);
    }
    return result;
  }
}