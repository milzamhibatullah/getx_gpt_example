import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/messages/model/chat.model.dart';
import 'package:getx_gpt_example/presentation/home/controllers/home.controller.dart';

import '../../../domain/messages/repository/messages.repository.dart';

class ChatController extends GetxController {
  ///define repository
  final _messageRepository = MessagesRepository();
  ///define states
  var isLoading=false.obs;
  var chats = <ChatModel>[].obs;
  @override
  void onReady() {
    _getChats();
    super.onReady();
  }

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
}
