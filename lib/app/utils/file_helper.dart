import 'dart:io';

import 'package:get/utils.dart';
import 'package:tugas_akhir_kripto/app/utils/aes_helper.dart';

class FileHelper{
  final String key;
  final String iv;
  late AESHelper aesHelper;

  FileHelper({
    required this.key,
    required this.iv
  }){
    aesHelper = AESHelper(keyString: key, ivString: iv);
  }

  Future<String> _getCustomDirectoryPath() async {
    final customDir = Directory('/storage/emulated/0/CryptChat/file');

    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
    }
    return customDir.path;
  }

  Future<bool> encryptFile(File inputFile, String fileName) async {
    try{
      final bytes = await inputFile.readAsBytes();
      final encryptedBytes = aesHelper.encryptFile(bytes);

      final directoryPath = await _getCustomDirectoryPath();
      final outputPath = '$directoryPath/$fileName.enc';

      final encryptedFile = File(outputPath);
      await encryptedFile.writeAsBytes(encryptedBytes);
      return true;
    }catch (e){
      return false;
    }
  }

  Future<bool> decryptFile(String encryptedFilePath, String outputFileName) async {
    try{
      final encryptedFile = File(encryptedFilePath);
      final encryptedBytes = await encryptedFile.readAsBytes();
      final decryptedBytes = aesHelper.decryptFile(encryptedBytes);

      final directoryPath = await _getCustomDirectoryPath();
      final outputPath = '$directoryPath/$outputFileName';

      final decryptedFile = File(outputPath);
      await decryptedFile.writeAsBytes(decryptedBytes);
      return true;
    }catch (e){
      e.printInfo();
      return false;
    }
  }
}