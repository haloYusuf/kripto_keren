import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir_kripto/app/utils/file_helper.dart';

class FileEncryptedController extends GetxController{
  late TextEditingController aesKeyController;
  late TextEditingController aesIVController;
  
  late FileHelper fileHelper;

  FilePickerResult? result;
  var isAnyResult = false.obs;

  FileEncryptedController(){
    aesKeyController = TextEditingController();
    aesIVController = TextEditingController();
  }

  Future<void> pickFile()async{
    try{
      var status = await Permission.storage.request();
      if (status.isGranted) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'png'],
        );
        isAnyResult.value = result != null;
        aesKeyController.clear();
        aesIVController.clear();
      }else if(status.isDenied){
        _showDialog(title: 'Error', message: 'Aplikasi tidak diizinkan untuk mengakses Storage.');
      }else if(status.isPermanentlyDenied){
        openAppSettings();
      }
    }catch (e){
      e.printError();
    }
  }
  
  void prosesEnkripsi()async{
    if(!isAnyResult.value){
      _showDialog(title: 'Error', message: 'Tidak ada file yang akan di enkripsi.');
    }else if(aesKeyController.text.isEmpty){
      _showDialog(title: 'Error', message: 'Aes Key tidak boleh kosong.');
    }else if(aesIVController.text.isEmpty){
      _showDialog(title: 'Error', message: 'Aes IV tidak boleh kosong.');
    }else if(aesKeyController.text.length != 16){
      _showDialog(title: 'Error', message: 'Panjang Aes Key harus 16.');
    }else if(aesKeyController.text.length != 16){
      _showDialog(title: 'Error', message: 'Panjang Aes IV harus 16.');
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      fileHelper = FileHelper(key: aesKeyController.text, iv: aesIVController.text);
      await fileHelper.encryptFile(File(result!.files.single.path!), result!.files.single.name).then((value){
        Get.back();
        if(value){
          _showDialog(title: 'Sukses', message: 'File berhasil di enkripsi.');
          isAnyResult.value = false;
          result = null;
          aesKeyController.clear();
          aesIVController.clear();
        }else{
          _showDialog(title: 'Gagal', message: 'File gagal di enkripsi.');
          aesKeyController.clear();
          aesIVController.clear();
        }
      });
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