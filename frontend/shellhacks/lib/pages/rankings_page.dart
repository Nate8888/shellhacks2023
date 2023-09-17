import 'package:flutter/material.dart';
import 'package:shellhacks/components/category_row.dart';
import 'package:shellhacks/components/company_card.dart';
import 'package:shellhacks/models/company_model.dart';
import 'package:shellhacks/services/rankings_service.dart';

class RankingsPage extends StatefulWidget {
  const RankingsPage({super.key});

  @override
  State<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  List<CompanyModel> companies = [];
  List<String> sectors = [];

  List<CompanyModel> filteredCompanies = [];
  bool showFilteredCompanies = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCompanies();
  }

  void getAllCompanies() async {
    companies = await RankingsService().getAllCompanies();
    if (mounted) setState(() {});

    getCompanySectors();
  }

  void getCompanySectors() {
    sectors = [];
    sectors.add("All");
    for (var company in companies) {
      if (!sectors.contains(company.sector)) {
        sectors.add(company.sector);
      }
    }
  }

  void setSector(String sector) {
    print("running set sector");
    print(sector);
    if (sector == "All") {
      setState(() {
        showFilteredCompanies = false;
      });
      return;
    }

    setState(() {
      showFilteredCompanies = true;
      filteredCompanies =
          companies.where((company) => company.sector == sector).toList();
    });
    print(filteredCompanies.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 214, 231, 246),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Top Companies',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Color.fromARGB(255, 13, 76, 128),
                  ),
                ),
              ),
              Container(
                height: 48.0,
                child: CategoryRow(categories: sectors, setSector: setSector),
                margin: const EdgeInsets.only(bottom: 20.0),
              ),
              Expanded(
                child: (companies.length == 0)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : showFilteredCompanies
                        ? ListView.builder(
                            itemCount: filteredCompanies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Card(
                                  // color: Color.fromARGB(0, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(18.0),
                                    child: CompanyCard(
                                        ticker: filteredCompanies[index].ticker,
                                        name: filteredCompanies[index].fullname,
                                        price: filteredCompanies[index].price,
                                        score: filteredCompanies[index]
                                            .esgCompanyScore),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: companies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Card(
                                  // color: Color.fromARGB(0, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(18.0),
                                    child: CompanyCard(
                                        ticker: companies[index].ticker,
                                        name: companies[index].fullname,
                                        price: companies[index].price,
                                        score:
                                            companies[index].esgCompanyScore),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
