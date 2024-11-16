import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/models/conversation_model.dart';
import 'package:tugas_akhir_kripto/app/data/models/message_model.dart';
import 'package:tugas_akhir_kripto/app/data/services/message_service.dart';

import '../../utils/aes_helper.dart';
import '../../utils/constants.dart';
import '../../utils/vigenere_cipher.dart';

class DetailChatController extends GetxController{
  late MessageService messageService;
  late GetStorage _box;
  late TextEditingController contentController;
  late ScrollController scrollController;

  late ConversationModel convData;
  late List<MessageModel> chatData;

  late AESHelper aesHelper;
  late VigenereCipher vigenereCipher;

  DetailChatController(){
    convData = Get.arguments['data'];
    chatData = [];
    contentController = TextEditingController();

    _box = GetStorage();
    messageService = MessageService();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(scrollController.hasClients){
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  String getTargetName(){
    var data = convData.personName;
    data.removeWhere((element) => element == _box.read(Constants.dataUser));
    return data.first;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(){
    return messageService.getAllMessage(convData.id);
  }

  bool isSender({required int index}){
    return chatData[index].senderToken == _box.read(Constants.dataUserToken);
  }

  String getUsername(){
    return _box.read(Constants.dataUser);
  }

  String getDateTimeChat(int index){
    return '${chatData[index].sendingDate.day}/${chatData[index].sendingDate.month}/${chatData[index].sendingDate.year} ${chatData[index].sendingDate.hour}:${chatData[index].sendingDate.minute}';
  }

  void getAllDecryptContent({required List<QueryDocumentSnapshot> data}){
    chatData = messageService.getData(data: data);

    aesHelper = AESHelper(keyString: convData.aesKey, ivString: convData.aesIV);
    vigenereCipher = VigenereCipher();

    String value = '';
    for(int i = 0; i < chatData.length; i++){
      value = aesHelper.decrypt(chatData[i].content);
      chatData[i].content = vigenereCipher.decrypt(value, convData.vigenereKey);
    }
  }

  void sendMessage()async{
    if(contentController.text.isNotEmpty){
      aesHelper = AESHelper(keyString: convData.aesKey, ivString: convData.aesIV);
      vigenereCipher = VigenereCipher();

      Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loading',
        content: const CircularProgressIndicator(),
      );

      final vigenereEncrypted = vigenereCipher.encrypt(contentController.text, convData.vigenereKey);
      await messageService.sendNewMessage(
        id: convData.id,
        message: aesHelper.encrypt(vigenereEncrypted),
      ).then((value){
        Get.back();
        contentController.clear();
        if(!value){
          _showDialog(
            title: 'Error',
            message: 'Gagal mengirim pesan.',
          );
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