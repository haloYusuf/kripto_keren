import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{
  late FirebaseFirestore _fireStore;

  ChatService(){
    _fireStore = FirebaseFirestore.instance;
  }
}