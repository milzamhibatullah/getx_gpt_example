
import 'package:getx_gpt_example/domain/messages/model/message.model.dart';
import 'package:getx_gpt_example/infrastructure/dal/services/message/message.service.dart';

class MessagesRepository {
  final _messageService = MessageService();

  /// get list messages
  Future<List<MessageModel>>getMessagesFromFirebase()=>_messageService.getMessageFromFirebase();
}