import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shellhacks/models/chat_message_model.dart';

class voiceChatService {
  final String backendUrl = 'https://hacktheshell.appspot.com';

  Future<ChatMessage?> submitChat(
      {required List<ChatMessage> history, required audioPath}) async {
    List<String> formattedHistory = [];
    history.forEach((element) {
      formattedHistory.add(element.userText);
      formattedHistory.add(element.chatbotText);
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://hacktheshell.appspot.com/talk'));

    request.fields.addAll({'conversations': formattedHistory.toString()});

    request.files.add(await http.MultipartFile.fromPath('audio', audioPath));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resString = await response.stream.bytesToString();

      final jsonResponse = jsonDecode(resString);
      print(jsonResponse['ai_text']);

      var returnedMessage = ChatMessage(
        userText: jsonResponse['user_text'],
        chatbotText: jsonResponse['ai_text'],
        userAudioLink: jsonResponse['user_input'],
        chatbotAudioLink: jsonResponse['ai_output'],
      );

      return returnedMessage;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
