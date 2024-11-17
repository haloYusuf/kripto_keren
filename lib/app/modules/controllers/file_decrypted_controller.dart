import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/file_helper.dart';

class FileDecryptedController extends GetxController{
  late TextEditingController aesKeyController;
  late TextEditingController aesIVController;

  late FileHelper fileHelper;

  FilePickerResult? result;
  var isAnyResult = false.obs;

  FileDecryptedController(){
    aesKeyController = TextEditingController();
    aesIVController = TextEditingController();
  }

  Future<void> pickFile()async{
    try{
      var status = await Permission.storage.request();
      if (status.isGranted) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['bin'],
        );
        if(result != null && result!.files.single.name.split('.').last != 'enc'){
          _showDialog(title: 'Error', message: 'File yang dapat diolah adalah file dengan format .enc');
          result = null;
        }
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

  void prosesDekripsi()async{
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
      var tempList = result!.files.single.name.split('.');
      tempList.removeLast();
      var fileName = tempList.join('.');
      await fileHelper.decryptFile(result!.files.single.path!, fileName).then((value){
        Get.back();
        if(value){
          _showDialog(title: 'Sukses', message: 'File berhasil di dekripsi.');
          isAnyResult.value = false;
          result = null;
          aesKeyController.clear();
          aesIVController.clear();
        }else{
          _showDialog(title: 'Gagal', message: 'File gagal di dekripsi. Cek kembali kunci yang digunakan.');
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