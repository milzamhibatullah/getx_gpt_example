import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_gpt_example/domain/messages/model/chat.model.dart';

class ChatService {
  ///initialize firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// initialize the collection
  late CollectionReference _collectionReference;

  ///define the collection
  String get _chatCollection => 'chats';

  String get _messageCollection => 'messages';

  Future<List<ChatModel>> getChatFromMessageId({docId}) async {
    try {
      ///initalize collection
      _collectionReference = _firestore
          .collection(_messageCollection)
          .doc(docId)
          .collection(_chatCollection);
      ///get the collections
      final results = await _collectionReference.get();
      return results.docs.map((e) => ChatModel.fromMap(e)).toList();
    } catch (e) {
      log('errpr message services => $e', name: 'MESSAGE SERVICES');
      throw 'error';
    }
  }
}
