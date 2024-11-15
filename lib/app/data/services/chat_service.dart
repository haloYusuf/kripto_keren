import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/models/chat_model.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class ChatService{
  late FirebaseFirestore _fireStore;
  late GetStorage _box;

  ChatService(){
    _fireStore = FirebaseFirestore.instance;
    _box = GetStorage();
  }
  
  Future<bool> isAnyUserInChat({
    required String targetToken,
  })async {
    var val = true;
    try{
      await _fireStore.collection('chats')
          .where('persons', arrayContains: _box.read(Constants.dataUserToken))
          .get()
          .then((value){
            val = value.docs.where(
                  (element)=> List<String>.from(element['persons']).contains(targetToken),
            ).toList().isNotEmpty;
          });
    }catch (e){
      val = true;
    }
    return val;
  }

  Future<bool> createNewChat({
    required String targetToken,
    required String aesKey,
    required String aesIV,
    required String vigenereKey,
  })async{
    var val = false;
    try{
      await _fireStore.collection('chats').doc().set({
        'persons': [_box.read(Constants.dataUserToken), targetToken],
        'aesKey': aesKey,
        'aesIV': aesIV,
        'vigenereKey': vigenereKey,
        'status': 0,
        'created_date': Timestamp.now(),
        'updated_date': Timestamp.now(),
      }).then((value){
        val = true;
      });
    }catch (e){
      val = false;
    }
    return val;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChat() {
    return _fireStore
        .collection('chats')
        .where('persons', arrayContains: _box.read(Constants.dataUserToken))
        .where('status', isEqualTo: 1)
        .snapshots();
  }

  List<ChatModel> getAllChatData({
    required List<QueryDocumentSnapshot> data,
  }) {
    return data.map((e) => ChatModel(
      id: e.id,
      persons:  List<String>.from((e['persons'] as List<dynamic>).map((e) => e.toString())),
      aesKey: e['aesKey'] ?? '',
      aesIV: e['aesIV'] ?? 0,
      vigenereKey: e['vigenereKey'],
      createdDate: (e['created_date'] as Timestamp).toDate(),
      updatedDate: (e['updated_date'] as Timestamp).toDate(),
    )).toList();
  }
}