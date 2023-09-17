import 'package:flutter/material.dart';
import 'package:shellhacks/components/article_card.dart';
import 'package:shellhacks/models/article_model.dart';
import 'package:shellhacks/models/company_model.dart';
import 'package:shellhacks/services/news_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<ArticleModel> articles = [];

  @override
  void initState() {
    super.initState();
    getAllCompanies();
  }

  void getAllCompanies() async {
    articles = await NewsService().getAllArticles();
    setState(() {});
  }

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
            Expanded(
              child: (articles.length == 0)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: 400.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ArticleCard(
                              headline: articles[index].heading,
                              subpoints: articles[index].esg,
                              hideCompanyCard: false,
                              headlineScore: articles[index].articleScore,
                              companyModel: CompanyModel(
                                  ticker: articles[index].ticker,
                                  fullname: articles[index].fullname,
                                  price: articles[index].price ?? 0.0,
                                  esgCompanyScore:
                                      articles[index].esgCompanyScore,
                                  sector: ''),
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
