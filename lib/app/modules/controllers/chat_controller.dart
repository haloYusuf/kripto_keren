import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/services/chat_service.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

import '../../data/models/chat_model.dart';

class ChatController extends GetxController{
  late ChatService chatService;
  late List<ChatModel> chatData;

  late GetStorage _box;

  ChatController(){
    chatService = ChatService();
    chatData = [];
    _box = GetStorage();
  }

  String getTargetName(int index){
    var data = chatData[index].persons;
    data.removeWhere((element) => element == _box.read(Constants.dataUserToken));
    return data.first;
  }
}