import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/stegano_algorithm.dart';

class SteganoDecryptedController extends GetxController{
  final List<String> items = ['Text', 'Foto'];
  var selectedItem = ''.obs;

  FilePickerResult? result;
  var isAnyResult = false.obs;

  late SteganoAlgorithm steganoAlgorithm;
  var messageResult = ''.obs;

  SteganoDecryptedController(){
    steganoAlgorithm = SteganoAlgorithm();
  }

  Future<void> pickFile()async{
    try{
      var status = await Permission.storage.request();
      if (status.isGranted) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        isAnyResult.value = result != null;
        selectedItem.value = '';
      }else if(status.isDenied){
        _showDialog(title: 'Error', message: 'Aplikasi tidak diizinkan untuk mengakses Storage.');
      }else if(status.isPermanentlyDenied){
        openAppSettings();
      }
    }catch (e){
      e.printError();
    }
  }

  void processDecryptedText()async{
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Loading',
      content: const CircularProgressIndicator(),
    );
    await steganoAlgorithm.extractMessage(result!.files.single.path!).then((value){
      Get.back();
      messageResult.value = value;
      if(messageResult.value.isEmpty){
        _showDialog(title: 'Gagal', message: 'Pesan gagal didapatkan.');
      }else{
        _showDialog(title: 'Sukses', message: 'Pesan berhasil didapatkan.');
      }
    });
  }

  void processDecryptedImage()async{
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Loading',
      content: const CircularProgressIndicator(),
    );
    var data = result!.files.single.name.split('.');
    data[data.length - 2] = 'decrypted';
    await steganoAlgorithm.extractImage(
      result!.files.single.path!,
      data.join('.')
    ).then((value){
      Get.back();
      if(value){
        _showDialog(title: 'Sukses', message: 'Pesan berhasil didapatkan.');
      }else{
        _showDialog(title: 'Gagal', message: 'Pesan gagal didapatkan.');
      }
      result = null;
      isAnyResult.value = false;
      messageResult.value = '';
    });
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