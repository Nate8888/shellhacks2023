import 'package:flutter/material.dart';
import 'package:shellhacks/components/article_card.dart';
import 'package:shellhacks/components/category_row.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'News',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: CategoryRow(
                categories: [
                  'Politics',
                  'Sports',
                  'Entertainment',
                  'Tech',
                  'Business',
                  'Science'
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // height: 400.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ArticleCard(
                        headlineScore: 8.0,
                        headline: 'Headline',
                        why: 'Why',
                        subpoints: ['Subpoint 1', 'Subpoint 2'],
                      ),
                    ),
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
