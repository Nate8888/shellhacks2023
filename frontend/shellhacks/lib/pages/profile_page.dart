import 'package:flutter/material.dart';
import 'package:shellhacks/components/article_card.dart';
import 'package:shellhacks/components/company_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CompanyCard(
              name: 'Google',
              ticker: 'GOOG',
              price: 3000.0,
              score: 3,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: ArticleCard(
                        headline: 'Article Headline',
                        why: 'Article Why',
                        subpoints: ['Subpoint 1', 'Subpoint 2', 'Subpoint 3'],
                        hideCompanyCard: true,
                        headlineScore: 8.0,
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
