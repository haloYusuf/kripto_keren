import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';

class SteganoAlgorithm{
  Future<String> _getCustomDirectoryPath(String status) async {
    final customDir = Directory('/storage/emulated/0/CryptChat/stegano/$status');

    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
    }
    return customDir.path;
  }

  Future<bool> hideMessageText({
    required String message,
    required String inputPath,
    required String name,
  }) async {
    try{
      final file = File(inputPath);
      final imageBytes = await file.readAsBytes();
      final image = decodeImage(imageBytes);

      if (image == null) {
        return false;
      }

      String binaryMessage = '${_textToBinary(message)}00000000';

      int messageIndex = 0;
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          if (messageIndex < binaryMessage.length) {
            Pixel pixel = image.getPixel(x, y);

            int red = pixel.getChannel(Channel.red).toInt();
            int green = pixel.getChannel(Channel.green).toInt();
            int blue = pixel.getChannel(Channel.blue).toInt();
            int alpha = pixel.getChannel(Channel.alpha).toInt();

            int newRed = (red & 0xFE) | int.parse(binaryMessage[messageIndex]);

            Color newColor = ColorRgba8(newRed, green, blue, alpha);
            image.setPixel(x, y, newColor);

            messageIndex++;
          } else {
            break;
          }
        }
      }

      String outputPath = await _getCustomDirectoryPath('enkripsi');
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(encodePng(image));
      return true;
    }catch (e){
      e.printInfo();
      return false;
    }
  }

  Future<String> extractMessage(String inputPath) async {
    try{
      final inputFile = File(inputPath);
      final imageBytes = await inputFile.readAsBytes();
      final image = decodeImage(imageBytes);

      if (image == null) {
        return '';
      }

      String binaryMessage = '';
      bool terminatorFound = false;

      outerLoop:
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          Pixel pixel = image.getPixel(x, y);
          int red = pixel.getChannel(Channel.red).toInt();

          binaryMessage += (red & 1).toString();

          if (binaryMessage.endsWith('00000000')) {
            terminatorFound = true;
            break outerLoop;
          }
        }
      }

      if (terminatorFound) {
        return _binaryToText(binaryMessage);
      } else {
        return '';
      }
    }catch (e){
      e.printInfo();
      return '';
    }
  }

  Future<bool> hideImage(String hostImagePath, String secretImagePath, String name) async {
    try{
      final hostFile = File(hostImagePath);
      final secretFile = File(secretImagePath);

      final hostImage = decodeImage(await hostFile.readAsBytes());
      final secretImage = await secretFile.readAsBytes();

      if (hostImage == null || secretImage.isEmpty) {
        return false;
      }

      int hostCapacity = hostImage.width * hostImage.height;

      String binaryData = _bytesToBinary(secretImage);

      int dataLengthBits = 32 + (binaryData.length);

      if (dataLengthBits > hostCapacity) {
        return false;
      }

      String lengthBinary = (secretImage.length).toRadixString(2).padLeft(32, '0');
      binaryData = lengthBinary + binaryData;

      int dataIndex = 0;
      for (int y = 0; y < hostImage.height; y++) {
        for (int x = 0; x < hostImage.width; x++) {
          if (dataIndex < binaryData.length) {
            Pixel pixel = hostImage.getPixel(x, y);

            int red = pixel.getChannel(Channel.red).toInt();
            int green = pixel.getChannel(Channel.green).toInt();
            int blue = pixel.getChannel(Channel.blue).toInt();
            int alpha = pixel.getChannel(Channel.alpha).toInt();

            int newRed = (red & 0xFE) | int.parse(binaryData[dataIndex]);
            dataIndex++;

            hostImage.setPixel(x, y, ColorRgba8(newRed, green, blue, alpha));
          }
        }
      }

      String outputPath = await _getCustomDirectoryPath('enkripsi');
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(encodePng(hostImage));
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> extractImage(String hostImagePath, String name) async {
    try{
      final hostFile = File(hostImagePath);
      final hostImage = decodeImage(await hostFile.readAsBytes());

      if (hostImage == null) {
        return false;
      }

      StringBuffer binaryData = StringBuffer();
      for (int y = 0; y < hostImage.height; y++) {
        for (int x = 0; x < hostImage.width; x++) {
          Pixel pixel = hostImage.getPixel(x, y);
          int red = pixel.getChannel(Channel.red).toInt();
          binaryData.write((red & 1).toString());
        }
      }

      String binaryString = binaryData.toString();

      if (binaryString.length < 32) {
        return false;
      }

      String lengthBinary = binaryString.substring(0, 32);
      int dataLength = int.parse(lengthBinary, radix: 2);

      int totalDataBits = 32 + (dataLength * 8);
      if (binaryString.length < totalDataBits) {
        return false;
      }

      String binarySecret = binaryString.substring(32, totalDataBits);

      List<int> secretBytes = _binaryToBytes(binarySecret);

      String outputPath = await _getCustomDirectoryPath('dekripsi');
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(secretBytes);
      return true;
    }catch (e){
      e.printInfo();
      return false;
    }
  }

  String _bytesToBinary(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join();
  }

  List<int> _binaryToBytes(String binary) {
    List<int> bytes = [];
    for (int i = 0; i < binary.length; i += 8) {
      String byte = binary.substring(i, i + 8);
      bytes.add(int.parse(byte, radix: 2));
    }
    return bytes;
  }

  String _binaryToText(String binary) {
    List<int> bytes = [];
    for (int i = 0; i < binary.length; i += 8) {
      String byte = binary.substring(i, i + 8);
      if (byte == '00000000') break; // Terminator
      bytes.add(int.parse(byte, radix: 2));
    }
    return String.fromCharCodes(bytes);
  }

  String _textToBinary(String text) {
    return text.codeUnits.map((unit) => unit.toRadixString(2).padLeft(8, '0')).join();
  }
}