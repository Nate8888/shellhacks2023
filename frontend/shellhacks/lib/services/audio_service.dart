import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioService {
  final record = Record();
  String audioPath = '';

  Future<String> startRecording() async {
    // get a path in data directory
    final directory = await getApplicationDocumentsDirectory();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = directory.path + '/recording_$timestamp.m4a';

    if (await record.hasPermission() == false) {
      print('need permissions');
    }

    await record.start(
      path: path,
    );

    // print(record.isRecording);
    audioPath = path;

    return path;
  }

  Future<String> stopRecording() async {
    // wait a quarter second
    await Future.delayed(const Duration(milliseconds: 250));

    await record.stop();
    return audioPath;
  }
}
