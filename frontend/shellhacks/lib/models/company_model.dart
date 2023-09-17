class CompanyModel {
  CompanyModel({
    required this.esgCompanyScore,
    required this.fullname,
    required this.ticker,
    required this.price,
    required this.sector,
  });

  final double esgCompanyScore;
  final String fullname;
  final String sector;
  final double price;
  final String ticker;
}
