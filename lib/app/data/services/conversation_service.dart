import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_kripto/app/data/models/conversation_model.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class ConversationService{
  late FirebaseFirestore _fireStore;
  late GetStorage _box;

  ConversationService(){
    _fireStore = FirebaseFirestore.instance;
    _box = GetStorage();
  }
  
  Future<bool> isAnyUserInChat({
    required String targetToken,
  })async {
    var val = true;
    try{
      await _fireStore.collection('conversations')
          .where('persons_token', arrayContains: _box.read(Constants.dataUserToken))
          .get()
          .then((value){
            val = value.docs.where(
                  (element)=> List<String>.from(element['persons_token']).contains(targetToken),
            ).toList().isNotEmpty;
          });
    }catch (e){
      val = true;
    }
    return val;
  }

  Future<bool> createNewChat({
    required String targetToken,
    required String targerName,
    required String aesKey,
    required String aesIV,
    required String vigenereKey,
  })async{
    var val = false;
    try{
      await _fireStore.collection('conversations').doc().set({
        'persons_token': [_box.read(Constants.dataUserToken), targetToken],
        'persons_name': [_box.read(Constants.dataUser), targerName],
        'user_request': _box.read(Constants.dataUserToken),
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

  List<ConversationModel> getData({
    required List<QueryDocumentSnapshot> data,
  }) {
    return data.map((e) => ConversationModel(
      id: e.id,
      personToken: List<String>.from((e['persons_token'] as List<dynamic>).map((e) => e.toString())),
      personName: List<String>.from((e['persons_name'] as List<dynamic>).map((e) => e.toString())),
      userRequest: e['user_request'] ?? '',
      aesKey: e['aesKey'] ?? '',
      aesIV: e['aesIV'] ?? 0,
      vigenereKey: e['vigenereKey'],
      createdDate: (e['created_date'] as Timestamp).toDate(),
      updatedDate: (e['updated_date'] as Timestamp).toDate(),
    )).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChat() {
    return _fireStore
        .collection('conversations')
        .where('persons_token', arrayContains: _box.read(Constants.dataUserToken))
        .where('status', isEqualTo: 1)
        .orderBy('updated_date', descending: true,)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllRequest() {
    return _fireStore
        .collection('conversations')
        .where('persons_token', arrayContains: _box.read(Constants.dataUserToken))
        .where('status', isEqualTo: 0)
        .where('user_request', isNotEqualTo: _box.read(Constants.dataUserToken))
        .orderBy('created_date', descending: true,)
        .snapshots();
  }

  Future<bool> removeInvitation({required String id}) async{
    bool val = false;
    try{
      await _fireStore.collection('conversations')
          .doc(id)
          .delete()
          .then((value) {
            val = true;
          });
    }catch (e){
      val = false;
    }
    return val;
  }

  Future<bool> acceptInvitation({required String id}) async{
    bool val = false;
    try{
      await _fireStore.collection('conversations')
          .doc(id)
          .update(
          {
            'status': 1,
            'updated_date': Timestamp.now(),
          }).then((value)async{
            val = true;
            // await _fireStore.collection('conversations').doc(id).collection('contents').doc().set({
            //   'message_content':
            // });
          });
    }catch (e){
      val = false;
    }
    return val;
  }
}