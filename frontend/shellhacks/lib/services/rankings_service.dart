import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shellhacks/models/company_model.dart';

class RankingsService {
  final String backendUrl = 'https://hacktheshell.appspot.com';

  Future<List<CompanyModel>> getAllCompanies() async {
    final response = await http.get(
      Uri.parse('$backendUrl/stocks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<CompanyModel> stocksList = [];

      var stocks = json.decode((utf8.decode(response.bodyBytes)));

      for (var stock in stocks) {
        try {
          var s = CompanyModel.fromJson(stock);
          stocksList.add(s);
        } catch (e) {
          print(e.toString());
        }
      }

      return stocksList;
    }

    return [];
  }
}
