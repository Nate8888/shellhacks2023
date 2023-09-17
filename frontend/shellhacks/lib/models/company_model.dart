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

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    double truncatedPrice =
        double.parse((json['Price'] as double).toStringAsFixed(2));

    double truncatedScore =
        double.parse((json['score'] as double).toStringAsFixed(1));

    return CompanyModel(
      esgCompanyScore: truncatedScore,
      fullname: json['Name'],
      ticker: json['Symbol'],
      price: truncatedPrice,
      sector: json['Sector'],
    );
  }
}
