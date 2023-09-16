class ChatMessage {
  ChatMessage({
    required this.userText,
    required this.userAudioLink,
    required this.chatbotText,
    required this.chatbotAudioLink,
  });

  final String userText;
  final String userAudioLink;
  final String chatbotText;
  final String chatbotAudioLink;
}
