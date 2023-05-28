import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/auth/user.repository.dart';
import 'package:getx_gpt_example/domain/messages/model/message.model.dart';
import 'package:getx_gpt_example/domain/messages/repository/messages.repository.dart';
import 'package:getx_gpt_example/infrastructure/navigation/routes.dart';

import '../../../domain/auth/model/user.dart';

class HomeController extends GetxController {
  ///define  repository
  final _userRepository = UserRepository();
  final _messageRepository = MessagesRepository();
  ///create states for data
  var user = User().obs;
  var messages = <MessageModel>[].obs;
  ///create loading value
  var isLoading= false.obs;
  ///set message data;
  var message = MessageModel().obs;


  @override
  void onReady() {
    _getUserInfo();
    _getMessages();
    super.onReady();
  }

  ///get local user info
  Future<void> _getUserInfo()async{
    try{
      user.value = await _userRepository.getUserInfo();
    }catch(e){
      log('error getUSerInfo : $e',name: 'HOME CONTROLLER');
    }
  }
  ///sign out from homescreen
  void signOut()async{
    try{
      await _userRepository.signOutGoogle();
      /// then go to auth screen
      Get.offAllNamed(Routes.AUTH);
    }catch(e){
      log('error signout : $e',name: 'HOME CONTROLLER');
      Get.rawSnackbar(message: 'error when signout');
    }
  }

  ///get list messages
  Future<void> _getMessages()async{
    try{
      ///initiate loading
      isLoading.value=true;
      ///call get messages from repository
      messages.value=await _messageRepository.getMessagesFromFirebase();
      ///try to display how much data
      log('count of messages ${messages.value.length}',name: 'Home Controller');
      ///stop loading
      Future.delayed(const Duration(seconds: 1),()=>isLoading.value=false);
    }catch(e){
      isLoading.value=false;
      Get.rawSnackbar(message: 'Failed to fetch messages');
    }
  }

  ///get list messages
  Future<void> addNewMessage()async{
    try{
      ///initiate loading
      isLoading.value=true;
      ///call get messages from repository
      await _messageRepository.addNewMessage();
      await _getMessages();
      navigateToChatScreen(messages.value.last);
      ///try to display how much data
      log('count of messages ${messages.value.length}',name: 'Home Controller');
      ///stop loading
      Future.delayed(const Duration(seconds: 1),()=>isLoading.value=false);
    }catch(e){
      isLoading.value=false;
      Get.rawSnackbar(message: 'Failed to fetch messages');
    }
  }

  /// navigate to chat screen
  void navigateToChatScreen(MessageModel model)async{
    ///set selected model message
    message.value=model;
    Get.toNamed(Routes.CHAT)?.whenComplete(()async => await _getMessages());
  }

  ///update the last message on message
  Future<void> updateLastMessage(msg)async{
    try{
      ///initiate loading
      isLoading.value=true;
      ///call get messages from repository
      await _messageRepository.updateLastMessage(message.value.docId,msg);
      await _getMessages();
      ///try to display how much data
      log('count of messages ${messages.value.length}',name: 'Home Controller');
      ///stop loading
      Future.delayed(const Duration(seconds: 1),()=>isLoading.value=false);
    }catch(e){
      isLoading.value=false;
     /// Get.rawSnackbar(message: 'Failed to fetch messages');
    }
  }
 Future<void> onRefreshData() async{
    await _getMessages();
 }
}
