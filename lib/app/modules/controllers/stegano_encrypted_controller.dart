import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir_kripto/app/utils/stegano_algorithm.dart';

class SteganoEncryptedController extends GetxController{
  final List<String> items = ['Text', 'Foto'];
  var selectedItem = ''.obs;

  FilePickerResult? resultHost;
  var isAnyResultHost = false.obs;
  FilePickerResult? resultSecret;
  var isAnyResultSecret = false.obs;
  late SteganoAlgorithm steganoAlgorithm;

  late TextEditingController messageController;

  SteganoEncryptedController(){
    messageController = TextEditingController();
    steganoAlgorithm = SteganoAlgorithm();
  }

  Future<void> pickHostImage()async{
    try{
      var status = await Permission.storage.request();
      if (status.isGranted) {
        resultHost = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        isAnyResultHost.value = resultHost != null;
        selectedItem.value = '';
        messageController.clear();
      }else if(status.isDenied){
        _showDialog(title: 'Error', message: 'Aplikasi tidak diizinkan untuk mengakses Storage.');
      }else if(status.isPermanentlyDenied){
        openAppSettings();
      }
    }catch (e){
      e.printError();
    }
  }

  Future<void> pickHiddenImage()async{
    try{
      var status = await Permission.storage.request();
      if (status.isGranted) {
        resultSecret = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        isAnyResultSecret.value = resultSecret != null;
        messageController.clear();
      }else if(status.isDenied){
        _showDialog(title: 'Error', message: 'Aplikasi tidak diizinkan untuk mengakses Storage.');
      }else if(status.isPermanentlyDenied){
        openAppSettings();
      }
    }catch (e){
      e.printError();
    }
  }

  void processEncryptedText()async{
    if(messageController.text.isEmpty){
      _showDialog(title: 'Error', message: 'Pesan tidak boleh kosong!');
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      var data = resultHost!.files.single.name.split('.');
      data[0] = '${data[0]}.encryptedtext';
      await steganoAlgorithm.hideMessageText(
        message: messageController.text,
        inputPath: resultHost!.files.single.path!,
        name: data.join('.'),
      ).then((value) {
        Get.back();
        if(value){
          _showDialog(title: 'Sukses', message: 'Pesan berhasil disisipkan. Lihat pada folder /CryptChat/stegano/enkripsi/.');
          resultHost = null;
          resultSecret = null;
          isAnyResultHost.value = false;
          isAnyResultSecret.value = false;
          selectedItem.value = '';
          messageController.clear();
        }else{
          _showDialog(title: 'Gagal', message: 'Pesan gagal disisipkan.');
        }
      });
    }
  }

  void processEncryptedImage()async{
    if(!isAnyResultSecret.value){
      _showDialog(title: 'Error', message: 'Pilih gambar yang ingin disembunyikan!');
    }else{
      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );
      var data = resultHost!.files.single.name.split('.');
      data[0] = '${data[0]}.encryptedimage';
      await steganoAlgorithm.hideImage(
        resultHost!.files.single.path!,
        resultSecret!.files.single.path!,
        data.join('.'),
      ).then((value){
        Get.back();
        if(value){
          _showDialog(title: 'Sukses', message: 'Gambar berhasil disisipkan. Lihat pada folder /CryptChat/stegano/enkripsi/.');
          resultHost = null;
          resultSecret = null;
          isAnyResultHost.value = false;
          isAnyResultSecret.value = false;
          selectedItem.value = '';
          messageController.clear();
        }else{
          _showDialog(title: 'Gagal', message: 'Gambar gagal disisipkan. Gambar host tidak cukup besar untuk menyimpan data atau gambar tidak berhasil di baca.');
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
      duration: const Duration(seconds: 2),
    );
  }
}