import 'package:flutter/foundation.dart';

class StockListProvider extends ChangeNotifier {
  List<String> _companies = [];

  List<String> get companies => _companies;

  void setCompanies(List<String> companies) {
    _companies = companies;
    notifyListeners();
  }
}
