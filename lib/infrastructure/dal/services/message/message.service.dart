
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
  ///get messsage from firebase
  Future<List<MessageModel>> getMessageFromFirebase()async{
    try{
      ///initalize collection
      _collectionReference = _firestore.collection(_collection);
      final results = await _collectionReference.orderBy('created_at').get();
      return results.docs.map((e) => MessageModel.fromMap(e)).toList();
    }catch(e){
      log('errpr message services => $e',name: 'MESSAGE SERVICES');
      throw 'error';
    }
  }

  ///add message
  Future<void>addNewMessage()async{
    try{
      ///initalize collection
      _collectionReference = _firestore.collection(_collection);
      ///add new message with initialize is '-'
      return await _collectionReference.doc().set({'last_message':'-','created_at':Timestamp.now()});
    }catch(e){
      log('error add message services => $e',name: 'MESSAGE SERVICES');
      throw 'error';
    }
  }


///update last message
  Future<void>updateLastMessage(docId,msg) async{
    try{
      ///initalize collection
      _collectionReference = _firestore.collection(_collection);
      ///add new message with initialize is '-'
      return await _collectionReference.doc(docId).set({'last_message':msg,'created_at':Timestamp.now()});
    }catch(e){
      log('error update message services => $e',name: 'MESSAGE SERVICES');
      throw 'error';
    }
  }
}