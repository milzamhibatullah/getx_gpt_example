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
  Future<List<ChatClass>> getChatFromMessageId({docId}) =>
      _chatService.getChatFromMessageId(docId: docId);
  ///add chats
  Future<void>addChats(docId,isBot,content)=>_chatService.addChats(docId, isBot, content);
  ///initiate open api
  Future<void> initiateOpenApi()=>_chatService.initiateOpenAiApi();

  ///send chats to ai
  Future<String?> sendChatToAi(question)=>_chatService.sendChatToAi(question: question);
}
