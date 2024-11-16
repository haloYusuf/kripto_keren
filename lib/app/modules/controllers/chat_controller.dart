import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/services/conversation_service.dart';
import 'package:tugas_akhir_kripto/app/routes/route_name.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

import '../../data/models/conversation_model.dart';

class ChatController extends GetxController{
  late ConversationService conversationService;
  late List<ConversationModel> chatData;

  late GetStorage _box;

  ChatController(){
    conversationService = ConversationService();
    chatData = [];
    _box = GetStorage();
  }

  String getTargetName(int index){
    var data = chatData[index].personName;
    data.removeWhere((element) => element == _box.read(Constants.dataUser));
    return data.first;
  }

  String getDateTimeChat(int index){
    return '${chatData[index].updatedDate.day}/${chatData[index].updatedDate.month}/${chatData[index].updatedDate.year} ${chatData[index].updatedDate.hour}:${chatData[index].updatedDate.minute}';
  }

  void toDetailChat({required int index}){
    Get.toNamed(
      RouteName.detailChat,
      arguments: {
        'data': chatData[index],
      }
    );
  }
}