import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${controller.user.value.name}')),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => controller.signOut(),
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=>controller.onRefreshData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(() => controller.isLoading.value
              ? const Padding(padding: EdgeInsets.symmetric(vertical: 20.0),child: Center(
            child: CircularProgressIndicator(),
          ),)
              : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              controller.messages.value.isEmpty
                  ? const Center(
                child: Text('No Messages Available'),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    controller.messages.value.length,
                        (index) => _itemMessage(index),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _itemMessage(int index) {
    final message = controller.messages.value[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        color: Get.theme.colorScheme.tertiaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message.lastMessage ?? 'no messages'),
          ),
        ),
      ),
    );
  }
}
