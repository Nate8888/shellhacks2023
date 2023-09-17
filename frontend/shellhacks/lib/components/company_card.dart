import 'package:flutter/material.dart';
import 'package:shellhacks/models/company_model.dart';
import 'package:shellhacks/pages/profile_page.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    Key? key,
    required this.ticker,
    required this.name,
    required this.price,
    required this.score,
    this.hideCompanyScore = false,
    this.noClickIn = false,
  }) : super(key: key);

  final String ticker;
  final String name;
  final double price;
  final double score;
  final bool hideCompanyScore;
  final bool noClickIn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (noClickIn) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              companyModel: CompanyModel(
                  esgCompanyScore: score,
                  fullname: name,
                  price: price,
                  sector: '',
                  ticker: ticker),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!hideCompanyScore)
              CircleAvatar(
                child: Text(
                  score.toString(),
                  style: const TextStyle(fontSize: 24.0),
                ),
                radius: 32.0,
              ),
            Container(
              width: 200,
              padding: EdgeInsets.only(left: hideCompanyScore ? 16 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticker,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '\$$price',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
