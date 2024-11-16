import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/models/message_model.dart';

import '../../utils/constants.dart';

class MessageService{
  late FirebaseFirestore _fireStore;
  late GetStorage _box;

  MessageService(){
    _fireStore = FirebaseFirestore.instance;
    _box = GetStorage();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(String id) {
    return _fireStore
        .collection('conversations')
        .doc(id)
        .collection('message')
        .orderBy('sending_date', descending: false,)
        .snapshots();
  }

  List<MessageModel> getData({
    required List<QueryDocumentSnapshot> data,
  }) {
    return data.map((e) => MessageModel(
      id: e.id,
      content: e['content'] ?? '',
      senderToken: e['sender_token'] ?? '',
      sendingDate: (e['sending_date'] as Timestamp).toDate(),
    )).toList();
  }

  Future<bool> sendNewMessage({
    required String id,
    required String message,
  })async{
    var val = false;
    try{
      await _fireStore.collection('conversations')
          .doc(id)
          .collection('message')
          .doc()
          .set({
        'content': message,
        'sender_token': _box.read(Constants.dataUserToken),
        'sending_date': Timestamp.now(),
      }).then((value){
        val = true;
      });
    }catch (e){
      val = false;
    }
    return val;
  }

}