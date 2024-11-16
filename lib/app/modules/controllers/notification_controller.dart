import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/data/services/conversation_service.dart';

import '../../data/models/conversation_model.dart';

class NotificationController extends GetxController{
  late ConversationService conversationService;
  late List<ConversationModel> notifData;

  NotificationController(){
    conversationService = ConversationService();
    notifData = [];
  }

  void hapusUndangan({required int index})async{
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Loading',
      content: const CircularProgressIndicator(),
    );
    conversationService.removeInvitation(
      id: notifData[index].id,
    ).then((value){
      Get.back();
      if(value){
        _showDialog(title: 'Sukses', message: 'Undangan berhasil dihapus.');
      }else{
        _showDialog(title: 'Error', message: 'Gagal menghapus undangan.');
      }
    });
  }

  void terimaUndangan({required int index})async{
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Loading',
      content: const CircularProgressIndicator(),
    );
    conversationService.acceptInvitation(
      id: notifData[index].id,
    ).then((value){
      Get.back();
      if(value){
        _showDialog(title: 'Sukses', message: 'Undangan berhasil diterima.');
      }else{
        _showDialog(title: 'Error', message: 'Gagal menerima undangan.');
      }
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