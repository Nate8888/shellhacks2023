import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      // padding: const EdgeInsets.all(8.0),
      color: Color.fromARGB(0, 255, 255, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!hideCompanyScore)
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 229, 208),
              child: Text(
                score.toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 244, 121, 49),
                ),
              ),
              radius: 30.0,
            ),
          InkWell(
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
              width: 160,
              padding: EdgeInsets.only(left: hideCompanyScore ? 16 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.0),
                  Text(
                    ticker,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: hideCompanyScore
                            ? Color.fromARGB(255, 244, 121, 49)
                            : Colors.black),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: Text(
              '\$$price',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
