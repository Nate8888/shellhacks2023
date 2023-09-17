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
  final double price;
  final String sector;
}
