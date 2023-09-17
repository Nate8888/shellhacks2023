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
    if (mounted) setState(() {});
  }

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
                'Relevant News',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  color: Color.fromARGB(255, 13, 76, 128),
                ),
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
                            borderOnForeground: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // surfaceTintColor: Color.fromARGB(255, 255, 159, 63),
                            shadowColor: Color.fromARGB(255, 228, 122, 22),
                            elevation: 5.0,
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
