import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shellhacks/models/article_model.dart';

class NewsService {
  final String backendUrl = 'https://hacktheshell.appspot.com';

  Future<List<ArticleModel>> getAllArticles() async {
    final response = await http.get(
      Uri.parse('$backendUrl/articles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<ArticleModel> articleList = [];

      var articles = json.decode((utf8.decode(response.bodyBytes)));

      for (var article in articles) {
        try {
          var a = ArticleModel.fromJson(article);
          articleList.add(a);
        } catch (e) {
          print(e.toString());
        }
      }

      return articleList;
    }

    return [];
  }
}
