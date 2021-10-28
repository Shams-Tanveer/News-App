import 'package:flutter/material.dart';
import 'package:news_app/Models/article_model.dart';
import 'package:news_app/Models/countrymodel.dart';
import 'package:news_app/Services/newarticle.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'article_view.dart';

class NewsCategory extends StatefulWidget {
  final String category;
  NewsCategory({required this.category});

  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryBasedNews newsList = CategoryBasedNews();
    await newsList.getCategoryTopNews(widget.category);
    articles = newsList.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black87,
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Canada",
                style: TextStyle(color: Colors.blue.shade900),
              ),
              Text(
                "TopNews",
                style: TextStyle(color: Colors.red.shade900),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: _loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 250.0),
                      child: DropdownButton<String>(
                        value: Country.name,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            Country.name = newValue!;
                            if (Country.name == "Canada") {
                              Country.countrycode = "ca";
                            } else if (Country.name == "UAE") {
                              Country.countrycode = "ae";
                            } else if (Country.name == "India") {
                              Country.countrycode = "in";
                            } else if (Country.name == "USA") {
                              Country.countrycode = "us";
                            } else if (Country.name == "Russian") {
                              Country.countrycode = "ru";
                            } else if (Country.name == "Australia") {
                              Country.countrycode = "au";
                            } else if (Country.name == "Germany") {
                              Country.countrycode = "de";
                            }
                            getCategoryNews();
                          });
                        },
                        items: <String>[
                          'Australia',
                          'Canada',
                          'Germany',
                          'India',
                          'UAE',
                          'USA'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return NewsTile(
                              imageUrl: articles[index].urlToImage ??
                                  "https://icoconvert.com/images/noimage2.png",
                              title: articles[index].title!,
                              description: articles[index].description ?? "",
                              url: articles[index].url!,
                              time: articles[index].publishedAt!,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, url, time;
  NewsTile(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.url,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      articleViewUrl: url,
                    )));
      },
      child: Container(
        // padding: EdgeInsets.only(bottom: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(imageUrl),
              borderRadius: BorderRadius.circular(6),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: Text(
                timeago.format(DateTime.parse(time)),
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
