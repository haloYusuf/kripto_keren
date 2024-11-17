import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';

class SteganoAlgorithm{
  Future<String> _getCustomDirectoryPath() async {
    final customDir = Directory('/storage/emulated/0/CryptChat/stegano');

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

      // Ubah pesan menjadi biner
      String binaryMessage = '${_textToBinary(message)}00000000'; // Tambah terminator (null byte)

      int messageIndex = 0;
      // Sisipkan bit pesan ke dalam LSB dari channel merah
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          if (messageIndex < binaryMessage.length) {
            Pixel pixel = image.getPixel(x, y);

            // Dapatkan channel warna
            int red = pixel.getChannel(Channel.red).toInt();
            int green = pixel.getChannel(Channel.green).toInt();
            int blue = pixel.getChannel(Channel.blue).toInt();
            int alpha = pixel.getChannel(Channel.alpha).toInt();

            // Modifikasi channel merah untuk menyembunyikan pesan
            int newRed = (red & 0xFE) | int.parse(binaryMessage[messageIndex]);

            // Buat warna baru dengan `ColorRgba8`
            Color newColor = ColorRgba8(newRed, green, blue, alpha);
            image.setPixel(x, y, newColor);

            messageIndex++;
          } else {
            break;
          }
        }
      }

      String outputPath = await _getCustomDirectoryPath();
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(encodePng(image));
      print('Pesan berhasil disembunyikan dan disimpan di: $outputPath');
      return true;
    }catch (e){
      e.printInfo();
      return false;
    }
  }

  // Fungsi untuk membaca pesan yang disembunyikan dari gambar
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

      // Loop melalui piksel dan ekstrak LSB
      outerLoop:
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          Pixel pixel = image.getPixel(x, y);
          int red = pixel.getChannel(Channel.red).toInt();

          // Ekstrak LSB dari channel merah
          binaryMessage += (red & 1).toString();

          // Periksa apakah kita menemukan terminator
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
      // Baca gambar host dan secret image
      final hostFile = File(hostImagePath);
      final secretFile = File(secretImagePath);

      final hostImage = decodeImage(await hostFile.readAsBytes());
      final secretImage = await secretFile.readAsBytes();

      if (hostImage == null) {
        print('Gagal memuat host image.');
        return false;
      }

      // Konversi secret image menjadi biner
      String binaryData = _bytesToBinary(secretImage);

      int dataIndex = 0;
      for (int y = 0; y < hostImage.height; y++) {
        for (int x = 0; x < hostImage.width; x++) {
          if (dataIndex < binaryData.length) {
            Pixel pixel = hostImage.getPixel(x, y);

            int red = pixel.getChannel(Channel.red).toInt();
            int green = pixel.getChannel(Channel.green).toInt();
            int blue = pixel.getChannel(Channel.blue).toInt();
            int alpha = pixel.getChannel(Channel.alpha).toInt();

            // Sisipkan bit dari secret image ke LSB dari channel merah
            int newRed = (red & 0xFE) | int.parse(binaryData[dataIndex]);
            dataIndex++;

            hostImage.setPixel(x, y, ColorRgba8(newRed, green, blue, alpha));
          }
        }
      }

      // Simpan gambar yang telah disisipi
      String outputPath = await _getCustomDirectoryPath();
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(encodePng(hostImage));
      print('Pesan berhasil disembunyikan dan disimpan di: $outputPath/$name');
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
        print('Gagal memuat host image.');
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

      // Konversi biner ke byte array
      List<int> secretBytes = _binaryToBytes(binaryData.toString());

      // Simpan secret image yang diekstrak
      String outputPath = await _getCustomDirectoryPath();
      final outputFile = File('$outputPath/$name');
      await outputFile.writeAsBytes(secretBytes);
      print('Gambar berhasil disimpan di: $outputPath/$name');
      return true;
    }catch (e){
      e.printInfo();
      return false;
    }
  }

  // Konversi byte array menjadi biner
  String _bytesToBinary(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join();
  }

  // Konversi biner menjadi byte array
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