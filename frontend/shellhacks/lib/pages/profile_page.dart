import 'package:flutter/material.dart';
import 'package:shellhacks/components/article_card.dart';
import 'package:shellhacks/components/company_card.dart';
import 'package:shellhacks/models/article_model.dart';
import 'package:shellhacks/models/company_model.dart';
import 'package:shellhacks/services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.companyModel});

  final CompanyModel companyModel;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ArticleModel> articles = [];

  @override
  void initState() {
    super.initState();
    getAllCompanies();
  }

  void getAllCompanies() async {
    articles =
        await ProfileService().getArticlesByCompany(widget.companyModel.ticker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompanyCard(
              noClickIn: true,
              name: widget.companyModel.fullname,
              ticker: widget.companyModel.ticker,
              price: widget.companyModel.price,
              score: widget.companyModel.esgCompanyScore,
            ),
            Expanded(
              child: (articles.length == 0)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ArticleCard(
                            headline: articles[index].heading,
                            subpoints: articles[index].esg,
                            hideCompanyCard: true,
                            headlineScore: articles[index].articleScore,
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