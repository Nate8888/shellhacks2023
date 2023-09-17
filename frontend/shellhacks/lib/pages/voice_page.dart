import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shellhacks/models/chat_message_model.dart';
import 'package:shellhacks/services/audio_service.dart';
import 'package:shellhacks/services/voice_chat_service.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final player = AudioPlayer();
  final AudioService _audioService = AudioService();
  String audioPath = '';
  bool isRecording = false;
  bool waitingForResponse = false;
  bool isPlaying = false;

  List<ChatMessage> _chatHistory = [];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPlayerEnded();
  }

  void _initPlayerEnded() {
    player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        isPlaying = false;
      });
    });
  }

  // listener for if playing switches to false
  // stop playback

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 229, 208),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                child: Text(
                  'Learn with Koi',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Color.fromARGB(255, 13, 76, 128),
                  ),
                ),
              ),
              Container(
                color: Color.fromARGB(255, 255, 229, 208),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 1.0),
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/waves.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          CircleAvatar(
                            radius: 120.0,
                            backgroundImage:
                                AssetImage('assets/Koi-water-bg.png'),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                'assets/bubbles.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                setState(() {
                                  _chatHistory = [];
                                  isPlaying = false;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 198.0,
                          child: ListView.builder(
                            itemCount: _chatHistory.length,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              final chatMessage = _chatHistory[index];
                              return Column(
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          82.0, 14.0, 42.0, 14.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          chatMessage.userText,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _playAudio(chatMessage.userAudioLink);
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          42.0, 14.0, 82.0, 14.0),
                                      child: Text(
                                        chatMessage.chatbotText,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    onTap: () {
                                      _playAudio(chatMessage.chatbotAudioLink);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _chatHistory.length == 0
                              ? 'Press and hold to speak'
                              : '',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8.0),
                        GestureDetector(
                          onTapDown: (_) {
                            if (waitingForResponse) {
                              return;
                            }
                            if (isPlaying) {
                              return;
                            }
                            // Start recording audio
                            _startRecording();
                          },
                          onTapUp: (_) async {
                            if (waitingForResponse) return;
                            if (isPlaying) {
                              player.stop();
                              setState(() {
                                isPlaying = false;
                              });
                              return;
                            }
                            // Stop recording audio and submit

                            await _submitAudio();
                          },
                          child: Container(
                            width: 66.0,
                            height: 66.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: waitingForResponse
                                  ? Colors.grey[400]
                                  : isRecording
                                      ? Color(0xFFA1E3F9)
                                      : Color(0xFFEC8F39),
                            ),
                            child: Center(
                              child: waitingForResponse
                                  ? Icon(
                                      Icons.hourglass_empty,
                                      size: 32.0,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      isPlaying ? Icons.stop : Icons.mic,
                                      size: 32.0,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _submitAudio() async {
    await _stopRecording();

    setState(() {
      waitingForResponse = true;
    });

    var res = await voiceChatService()
        .submitChat(audioPath: audioPath, history: _chatHistory);

    setState(() {
      waitingForResponse = false;
    });

    if (res == null) return;

    setState(() {
      _chatHistory.add(res);
    });

    Future.delayed(Duration(milliseconds: 250), () {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });

    _playAudio(res.chatbotAudioLink);
  }

  Future<void> _startRecording() async {
    try {
      setState(() {
        isRecording = true;
      });
      _audioService.startRecording();

      print("recording started");
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      var path = await _audioService.stopRecording();

      setState(() {
        isRecording = false;
        audioPath = path;
      });

      print("recording finished");
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _playAudio(String url) async {
    try {
      print("playing audio");
      setState(() {
        isPlaying = true;
      });
      print("isPlaying set to true:");
      print(isPlaying);
      await player.play(UrlSource(url));
      // setState(() {
      //   // isPlaying = false;
      // });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}
