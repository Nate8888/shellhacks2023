import 'package:flutter/material.dart';
import 'package:shellhacks/models/chat_message_model.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final List<ChatMessage> _chatHistory = [
    ChatMessage(
        userText: "what's apples esg score?",
        userAudioLink: '',
        chatbotText: "Apple's esg score is 8.1",
        chatbotAudioLink: ''),
    ChatMessage(
        userText: "why is that?",
        userAudioLink: '',
        chatbotText: "do to thier recent investments in the electric apple car",
        chatbotAudioLink: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 18.0),
          CircleAvatar(
            radius: 80.0,
            // backgroundImage: AssetImage('assets/chatbot.png'),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.only(right: 32.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      // Reset chat history
                    },
                  ),
                ),
              ),
              Container(
                height: 300.0,
                child: ListView.builder(
                  itemCount: _chatHistory.length,
                  itemBuilder: (BuildContext context, int index) {
                    final chatMessage = _chatHistory[index];
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.fromLTRB(82.0, 14.0, 42.0, 14.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              chatMessage.userText,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.fromLTRB(42.0, 14.0, 82.0, 14.0),
                          child: Text(
                            chatMessage.chatbotText,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          GestureDetector(
            onTapDown: (_) {
              // Start recording audio
              // await _startRecording();
            },
            onTapUp: (_) {
              // Stop recording audio and submit
              // await _stopRecording();
              _submitAudio();
            },
            child: Container(
              width: 66.0,
              height: 66.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: const Center(
                child: Icon(
                  Icons.mic,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAudio() {
    // Submit audio to chatbot
  }
}
