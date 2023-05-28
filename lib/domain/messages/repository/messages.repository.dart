import 'package:getx_gpt_example/domain/messages/model/chat.model.dart';
import 'package:getx_gpt_example/domain/messages/model/message.model.dart';
import 'package:getx_gpt_example/infrastructure/dal/services/message/chat.service.dart';
import 'package:getx_gpt_example/infrastructure/dal/services/message/message.service.dart';

class MessagesRepository {
  final _messageService = MessageService();
  final _chatService = ChatService();

  /// get list messages
  Future<List<MessageModel>> getMessagesFromFirebase() =>
      _messageService.getMessageFromFirebase();

  ///get list chate by messages doc id
  Future<List<ChatModel>> getChatFromMessageId({docId}) =>
      _chatService.getChatFromMessageId(docId: docId);
}
