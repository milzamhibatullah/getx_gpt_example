import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/auth/user.repository.dart';
import 'package:getx_gpt_example/infrastructure/navigation/routes.dart';

import '../../../domain/auth/model/user.dart';

class HomeController extends GetxController {
  ///define user repository
  final _userRepository = UserRepository();
  ///create states for user data
  var user = User().obs;
  ///create loading value
  var isLoading= false.obs;



  @override
  void onReady() {
    _getUserInfo();
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

}
