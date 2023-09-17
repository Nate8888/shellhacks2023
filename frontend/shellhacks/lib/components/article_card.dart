import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shellhacks/components/company_card.dart';
import 'package:shellhacks/models/company_model.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard(
      {Key? key,
      required this.headline,
      required this.subpoints,
      required this.headlineScore,
      this.hideCompanyCard = false,
      this.companyModel})
      : super(key: key);

  final String headline;
  final List<String> subpoints;
  final bool hideCompanyCard;
  final double headlineScore;
  final CompanyModel? companyModel;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _showSubpoints = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _showSubpoints = !_showSubpoints;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color.fromARGB(255, 254, 253, 251),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        widget.headline,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black54,
                        ),
                        maxLines: 4, // Allows text to wrap up to 3 lines
                        overflow: TextOverflow
                            .ellipsis, // Adds ellipsis (...) at the end if text overflows
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(225, 248, 255, 1),
                    child: Text(
                      widget.headlineScore.toString(),
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color.fromARGB(255, 13, 76, 128),
                      ),
                    ),
                    radius: 42.0,
                  ),
                ],
              ),
            ),
            if (!widget.hideCompanyCard)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: CompanyCard(
                  name: widget.companyModel?.fullname ?? '',
                  ticker: widget.companyModel?.ticker ?? '',
                  price: widget.companyModel?.price ?? 0.0,
                  score: widget.companyModel?.esgCompanyScore ?? 0.0,
                  hideCompanyScore: true,
                ),
              ),
            const SizedBox(height: 6.0),
            if (_showSubpoints)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.subpoints.map((subpoint) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check,
                              size: 30.0,
                              weight: 100,
                              color: Color.fromARGB(194, 13, 76, 128),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                subpoint,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
