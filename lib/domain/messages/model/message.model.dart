
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
   String? docId;
   String? lastMessage;
  MessageModel({this.docId,this.lastMessage});

  ///converting snapshot to model
  MessageModel.fromMap(DocumentSnapshot snapshot){
    docId=snapshot.id;
    lastMessage=snapshot['last_message'];
  }

}