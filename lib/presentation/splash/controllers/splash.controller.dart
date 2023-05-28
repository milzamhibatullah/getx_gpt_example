import 'package:get/get.dart';
import 'package:getx_gpt_example/domain/auth/user.repository.dart';
import 'package:getx_gpt_example/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final _authRepository = UserRepository();
  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2),()async{
      if(await _authRepository.isSignIn()){
        Get.offAllNamed(Routes.HOME);
      }else{
        Get.offAllNamed(Routes.AUTH);
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
