import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/constants.dart';

class UserService{
  late FirebaseFirestore _fireStore;
  late GetStorage _box;

  UserService(){
    _fireStore = FirebaseFirestore.instance;
    _box = GetStorage();
  }

  Future<bool> loginProcess({
    required String uName,
    required String pass,
  }) async{
    var val = false;
    try{
      await _fireStore.collection('users')
          .where('username', isEqualTo: uName)
          .where('password', isEqualTo: pass)
          .get()
          .then((value){
            if(value.size > 0){
              _box.write(Constants.dataIsLogin, true);
              _box.write(Constants.dataUserToken, value.docs.first.data()['token']);
              _box.write(Constants.dataUser, value.docs.first.data()['username']);
              val = true;
            }
          }
      );
    }catch (e){
      val = false;
    }
    return val;
  }

  Future<bool> registerProcess({
    required String uName,
    required String pass,
    required String token,
  })async{
    var val = false;
    try{
      await _fireStore.collection('users').doc('us$token').set({
        'username': uName,
        'password': pass,
        'token': token,
      }).then((value){
        _box.write(Constants.dataIsLogin, true);
        _box.write(Constants.dataUserToken, token);
        _box.write(Constants.dataUser, uName);
        val = true;
      });
    }catch (e){
      val = false;
    }
    return val;
  }

  Future<bool> isAnyUser({
    required String uName,
  }) async{
    var val = false;
    try{
      await _fireStore.collection('users')
          .where('username', isEqualTo: uName)
          .get()
          .then((value){
            val = value.size < 1;
          });
    }catch (e){
      val = false;
    }
    return val;
  }

  Future<String> getUserToken({
    required String uName,
  }) async{
    var val = '';
    try{
      await _fireStore.collection('users')
          .where('username', isEqualTo: uName)
          .get()
          .then((value){
            val = value.docs.first.data()['token'] ?? '';
          });
    }catch (e){
      val = '';
    }
    return val;
}

}