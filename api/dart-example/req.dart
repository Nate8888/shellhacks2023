var request = http.MultipartRequest('POST', Uri.parse('https://hacktheshell.appspot.com/talk'));
request.fields.addAll({
  'conversations': '["What a wonderful day!"]'
});
request.files.add(await http.MultipartFile.fromPath('audio', '/C:/Users/wilkn/Downloads/output.mp3'));

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}