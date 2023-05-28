
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
   String? docId;
   String? lastMessage;
   Timestamp? timestamp;
  MessageModel({this.docId,this.lastMessage,this.timestamp});

  ///converting snapshot to model
  MessageModel.fromMap(DocumentSnapshot snapshot){
    docId=snapshot.id;
    lastMessage=snapshot['last_message'];
    timestamp=snapshot['created_at'];
  }

}