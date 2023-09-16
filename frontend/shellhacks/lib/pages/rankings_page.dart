import 'package:flutter/material.dart';
import 'package:shellhacks/components/category_row.dart';
import 'package:shellhacks/components/company_card.dart';

class RankingsPage extends StatefulWidget {
  const RankingsPage({super.key});

  @override
  State<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Rankings',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              height: 48.0,
              child: CategoryRow(
                categories: [
                  'Category 1',
                  'Category 2',
                  'Category 3',
                  'Category 4',
                  'Category 5',
                ],
              ),
              margin: const EdgeInsets.only(bottom: 20.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: CompanyCard(
                        ticker: "Appl", name: "Apple", price: 100.0, score: 8),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
