
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_gpt_example/domain/messages/model/message.model.dart';

class MessageService{
  ///initialize firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /// initialize the collection
  late CollectionReference _collectionReference;
  ///define the collection
  String  get _collection =>'messages';
  Future<List<MessageModel>> getMessageFromFirebase()async{
    try{
      ///initalize collection
      _collectionReference = _firestore.collection(_collection);
      final results = await _collectionReference.get();
      return results.docs.map((e) => MessageModel.fromMap(e)).toList();
    }catch(e){
      log('errpr message services => $e',name: 'MESSAGE SERVICES');
      throw 'error';
    }
  }
}