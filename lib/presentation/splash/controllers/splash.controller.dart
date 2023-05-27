import 'package:get/get.dart';

class SplashController extends GetxController {

  final count = 0.obs;
  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2),()=>Get.offAllNamed('/home'));
    print('here');
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
