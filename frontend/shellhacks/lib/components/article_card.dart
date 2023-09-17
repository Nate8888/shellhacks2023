import 'package:flutter/material.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.headline,
                    style: TextStyle(fontSize: 30),
                    maxLines: 3, // Allows text to wrap up to 3 lines
                    overflow: TextOverflow
                        .ellipsis, // Adds ellipsis (...) at the end if text overflows
                  ),
                ),
                CircleAvatar(
                  child: Text(
                    widget.headlineScore.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  radius: 32.0,
                ),
              ],
            ),
          ),
          if (!widget.hideCompanyCard)
            CompanyCard(
              name: widget.companyModel?.fullname ?? '',
              ticker: widget.companyModel?.ticker ?? '',
              price: widget.companyModel?.price ?? 0.0,
              score: widget.companyModel?.esgCompanyScore ?? 0.0,
              hideCompanyScore: true,
            ),
          const SizedBox(height: 16.0),
          if (_showSubpoints)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.subpoints.map((subpoint) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check, size: 16.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            subpoint,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
