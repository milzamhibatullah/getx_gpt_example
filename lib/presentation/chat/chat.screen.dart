import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/chat.controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Chats'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),

                    ///chats
                    controller.chats.value.isNotEmpty
                        ? ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              controller.chats.value.length,
                              (index) => controller.chats.value[index].isBot ==
                                      false
                                  ? _userChatWidget(
                                      msg:
                                          controller.chats.value[index].content)
                                  : _receiveChatWidget(
                                      msg: controller
                                          .chats.value[index].content),
                            ),
                          )
                        : Container()
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: MediaQuery.of(context).size.width,
        padding: MediaQuery.of(context).viewInsets,

        ///text field elevation
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              flex: 1,
              child: Material(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  maxLines: null,
                  // controller: controller,
                  // style: appFonts.style(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: 'Ask a question ... ',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    // hintStyle: appFonts.style(weight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 6.0,
            ),
            FloatingActionButton(
              onPressed: () {
                // if (controller.text.isNotEmpty) {
                //   _submitChat();
                // }
              },
              elevation: 10.0,
              child: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }

  _userChatWidget({msg}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              width: (Get.size.width / 2)+30.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(msg,style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

  _receiveChatWidget({msg}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (Get.size.width/2)+40,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(msg,style: const TextStyle(color: Colors.white),),
            ),
          ],
        ),
      );
}
