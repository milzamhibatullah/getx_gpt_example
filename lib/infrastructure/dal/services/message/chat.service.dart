import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_gpt_example/domain/messages/model/chat.model.dart';

class ChatService {
  ///define open ai variable
  late OpenAI openAi;

  ///initialize firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// initialize the collection
  late CollectionReference _collectionReference;

  ///define the collection
  String get _chatCollection => 'chats';

  String get _messageCollection => 'messages';

  ///ggpt key
  String get _gptKey => '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';

  ///initiate openai apikey
  Future<void> initiateOpenAiApi() async {
    try {
      openAi = OpenAI.instance.build(
          token: _gptKey,
          baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 60),
            connectTimeout: const Duration(seconds: 60),
          ),
          enableLog: true);
    } catch (e) {
      log('error initiate open ai : $e', name: 'CHAT SERVICE');
    }
  }

  ///get list chats
  Future<List<ChatClass>> getChatFromMessageId({docId}) async {
    try {
      ///initalize collection
      _collectionReference = _firestore
          .collection(_messageCollection)
          .doc(docId)
          .collection(_chatCollection);

      ///get the collections
      final results = await _collectionReference.orderBy('created_at').get();
      return results.docs.map((e) => ChatClass.fromMap(e)).toList();
    } catch (e) {
      log('errpr chat services => $e', name: 'CHAT SERVICE');
      throw 'error';
    }
  }

  Future<void>addChats(docId,isBot,content){
    try {
      ///initalize collection
      _collectionReference = _firestore
          .collection(_messageCollection)
          .doc(docId)
          .collection(_chatCollection);

      ///get the collections
      return _collectionReference.add({'is_bot':isBot,'content':content, 'created_at':Timestamp.now()});
    } catch (e) {
      log('errpr chat services => $e', name: 'CHAT SERVICE');
      throw 'error';
    }
  }
  ///send chats to chat gpt
  Future<String?> sendChatToAi({question}) async {
    try {
      ///create request
      final request = ChatCompleteText(
          model: ChatModel.gptTurbo0301,
          messages: [
            ///role means,user is us when request
            Map.of({
              "role": "user",
              "content": "$question"
            })
          ],
          maxToken: 200);

      ///send a request
      final response = await openAi.onChatCompletion(request: request);
      var aiMessage='';
      if(response!=null){
        response.choices.forEach((element) {
          log('result gpt : ${element.message!.content}');
          aiMessage= element.message!.content;
        });

        return aiMessage;
      }else{
        throw 'error';
      }

    } catch (e) {
      log('error submit chat services => $e', name: 'CHAT SERVICE');
      throw 'error';
    }
  }
}
