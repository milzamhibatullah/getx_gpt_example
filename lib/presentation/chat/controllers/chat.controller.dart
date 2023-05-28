import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/messages/model/chat.model.dart';
import 'package:getx_gpt_example/presentation/home/controllers/home.controller.dart';

import '../../../domain/messages/repository/messages.repository.dart';

class ChatController extends GetxController {
  ///define repository
  final _messageRepository = MessagesRepository();
  ///define states
  var isLoading=false.obs;
  var isGptOnLoading=false.obs;
  var chats = <ChatClass>[].obs;
  @override
  void onReady() {
    _messageRepository.initiateOpenApi();
    _getChats();
    super.onReady();
  }


  ///get list chats
  Future<void>_getChats()async{
    try{
      isLoading.value=true;
      ///get message id using injection
      final docId = Get.find<HomeController>().message.value.docId;
      ///fetch data by doc id
      chats.value = await _messageRepository.getChatFromMessageId(docId: docId);
      ///check count data(optional)
      log('count of chats by $docId is ${chats.value.length}');
      ///stoploading
      Future.delayed(const Duration(seconds: 1),()=>isLoading.value=false);
    }catch(e){
      log('error get chats : $e',name: 'Chat Controller');
      isLoading.value=false;
      Get.rawSnackbar(message: 'Failed to fetch chat');
    }
  }

  ///add chats
  Future<void>_addChats(isBot,content)async{
    try{
      ///get message id using injection
      final docId = Get.find<HomeController>().message.value.docId;
      ///add chat to firebase
      await _messageRepository.addChats(docId, isBot, content);

    }catch(e){
      log('error add chats : $e',name: 'Chat Controller');

    }
  }

  ///send chats to ai
  Future<void>sendChatsToAi(question,ScrollController scrollController)async{
    try{
      _animateScrollToBottom(scrollController);
      ///set loading
      isGptOnLoading.value=true;
      ///add the user question to chats firebase
      _addChats(false, question);
       ///add the user question to chats observable
       chats.value.add(ChatClass(content: question,isBot: false));
       /// send question to ai
       final response =await _messageRepository.sendChatToAi(question);
      ///add the response to chats firebase
      _addChats(true, response);
      ///add response to chats model
       chats.value.add(ChatClass(docId: 'i1231dasd124',content: response,isBot: true));
      isGptOnLoading.value=false;
      _animateScrollToBottom(scrollController);
      await Get.find<HomeController>().updateLastMessage(chats.value.last.content);
    }catch(e){
      log('error get chats : $e',name: 'Chat Controller');
      isLoading.value=false;
      Get.rawSnackbar(message: 'Failed to fetch chat');
    }
  }

  _animateScrollToBottom(ScrollController scrollController){
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }
}
