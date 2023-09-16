import 'package:flutter/material.dart';
import 'package:shellhacks/components/company_card.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({
    Key? key,
    required this.headline,
    required this.why,
    required this.subpoints,
    required this.headlineScore,
    this.hideCompanyCard = false,
  }) : super(key: key);

  final String headline;
  final String why;
  final List<String> subpoints;
  final bool hideCompanyCard;
  final double headlineScore;

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
                Text(
                  widget.headline,
                  style: Theme.of(context).textTheme.headline4,
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
            const CompanyCard(
              name: 'Google',
              ticker: 'GOOG',
              price: 3000.0,
              score: 3,
              hideCompanyScore: true,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Why',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.why,
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
