import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/auth/user.repository.dart';

import '../../../infrastructure/navigation/routes.dart';

class AuthController extends GetxController {
  final _authRepository = UserRepository();
  var isLoading = false.obs;
  void signIn()async{
    try{
      ///set loading on true
      isLoading.value = true;
     /// call signin with google from repository
      await _authRepository.signInWithGoogle();
      /// set is loading false
      isLoading.value=false;
      /// if success redirect to home page
      Get.offAllNamed(Routes.HOME);
    }catch(e){
      isLoading.value=false;
      /// if there are errors display snackbar
      Get.rawSnackbar(message: 'Failed to sign in');
    }
  }
}
