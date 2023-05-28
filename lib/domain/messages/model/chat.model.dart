
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  String? docId;
  String? content;
  bool? isBot;
  ChatModel({this.docId,this.content,this.isBot});

  ///converting snapshot to model
  ChatModel.fromMap(DocumentSnapshot snapshot){
    docId=snapshot.id;
    isBot=snapshot['is_bot'];
    content=snapshot['content'];
  }

}