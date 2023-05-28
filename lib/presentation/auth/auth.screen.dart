import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/auth.controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(()=>controller.isLoading.value?const CircularProgressIndicator():OutlinedButton(
          onPressed: () => controller.signIn(),
          child: const Text('sign in with google'),
        )),
      ),
    );
  }
}
