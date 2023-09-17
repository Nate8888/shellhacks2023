class ArticleModel {
  ArticleModel({
    required this.esg,
    required this.esgCompanyScore,
    required this.fullname,
    required this.heading,
    required this.articleScore,
    required this.ticker,
    required this.price,
    required this.sector,
  });

  final List<String> esg;
  final double esgCompanyScore;
  final String fullname;
  final String heading;
  final double articleScore;
  final String ticker;
  final double? price;
  final String? sector;

  // factory ArticleModel.fromJson(Map<String, dynamic> json) {
  //   return ArticleModel(
  //     esg: List<String>.from(json['esg']?.map((x) => x.toString()) ?? []),
  //     esgCompanyScore: (json['esg_company_score'] ?? 0.0).toDouble(),
  //     fullname: json['fullname'] ?? '',
  //     heading: json['heading'] ?? '',
  //     articleScore: (json['score'] ?? 0.0).toDouble(),
  //     ticker: json['ticker'] ?? '',
  //     price: (json['price'] ?? 0.0)
  //         .toDouble(), // Providing a default value since 'price' key is not in the JSON
  //     sector: json['sector'] ??
  //         '', // Providing a default value since 'sector' key is not in the JSON
  //   );
  // }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    List<String> esgList = [];
    if (json['esg'] != null) {
      for (var esg in json['esg']) {
        esgList.add(esg.toString());
      }
    }

    var price = 0.0;
    if (json['Price'] != null)
      price = json['Price'];
    else if (json['price'] != null)
      price = json['price'];
    else
      price = 0.0;

    double? truncatedPrice = double.parse((price).toStringAsFixed(2)) ?? 0.0;

    double? truncatedCompanyScore =
        double.parse((json['esg_company_score'] as double).toStringAsFixed(1));

    var articleScore = 0.0;
    if (json['score'] != null)
      articleScore = json['score'];
    else if (json['Score'] != null)
      articleScore = json['Score'];
    else
      articleScore = 0.0;

    double truncatedArticleScore =
        double.parse((articleScore as double).toStringAsFixed(1));
    try {
      return ArticleModel(
        esg: esgList,
        esgCompanyScore: truncatedCompanyScore,
        // esgCompanyScore: 0.0,
        fullname: json['fullname'] ?? '',
        heading: json['heading'] ?? '',
        articleScore: truncatedArticleScore,
        // articleScore: 0.0,
        ticker: json['ticker'] ?? '',
        price:
            truncatedPrice, // Providing a default value since 'price' key is not in the JSON
        // price: 0.0,
        // price: price,
        sector: json['sector'] ??
            '', // Providing a default value since 'sector' key is not in the JSON
      );
    } catch (e) {
      String fieldName = e.toString().split('\'')[1];
      print(
          'Error parsing ArticleModel JSON: Invalid value for field $fieldName');
      rethrow;
    }
  }
}
