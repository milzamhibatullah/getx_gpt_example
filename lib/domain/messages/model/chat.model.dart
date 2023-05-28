
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatClass{
  String? docId;
  String? content;
  Timestamp? createdAt;
  bool? isBot;
  ChatClass({this.docId,this.content,this.isBot,this.createdAt});

  ///converting snapshot to model
  ChatClass.fromMap(DocumentSnapshot snapshot){
    docId=snapshot.id;
    isBot=snapshot['is_bot'];
    createdAt=snapshot['created_at'];
    content=snapshot['content'];
  }

}