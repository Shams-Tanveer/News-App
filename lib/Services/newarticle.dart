import 'dart:convert';

import 'package:news_app/Models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/countrymodel.dart';
import 'package:news_app/Models/sourcemodel.dart';

class News{
  List<ArticleModel> news =[];

  Future<void> getTopNews()async {
    String ccode = Country.countrycode;
    String url ="https://newsapi.org/v2/top-headlines?country=$ccode&apiKey=711d9676fe8f414a807b2e686d020e43";

    var response =await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body); 
    if(response.statusCode == 200)
    {
      jsonData["articles"].forEach((element){

        ArticleModel articleModel =  ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          publishedAt: element["publishedAt"],
        );
        news.add(articleModel);

      });
    }
  }
}

class CategoryBasedNews{
  List<ArticleModel> news =[];
    String ccode = Country.countrycode;

  Future<void> getCategoryTopNews(String category)async {
    String url ="https://newsapi.org/v2/top-headlines?country=$ccode&category=$category&apiKey=711d9676fe8f414a807b2e686d020e43";

    var response =await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body); 
    if(response.statusCode == 200)
    {
      jsonData["articles"].forEach((element){
       // if(element["urlToImage"]!=null && element["description"]!=null){
        ArticleModel articleModel =  ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          publishedAt: element["publishedAt"],
        );
        news.add(articleModel);
       // }
      });
    }
  }
}

class SearchedBasedNews{
  List<ArticleModel> news =[];
    String ccode = Country.countrycode;


  Future<void> getSearchedNews(String searchedValue)async {
    String url ="https://newsapi.org/v2/top-headlines?country=$ccode&q=$searchedValue&apiKey=711d9676fe8f414a807b2e686d020e43";

    var response =await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body); 
    if(response.statusCode == 200)
    {
      jsonData["articles"].forEach((element){
       // if(element["urlToImage"]!=null && element["description"]!=null){
        ArticleModel articleModel =  ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          publishedAt: element["publishedAt"],
        );
        news.add(articleModel);
       // }
      });
    }
  }
}

class Source{
  List<SourceModel> sources =[];

  Future<void> getTopSource()async {
    String url ="https://newsapi.org/v2/top-headlines/sources?country=us&apiKey=711d9676fe8f414a807b2e686d020e43";

    var response =await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body); 
    if(response.statusCode == 200)
    {
      jsonData["sources"].forEach((element){

        SourceModel articleModel =  SourceModel(
          id: element["id"],
          name: element["name"],
        );
        sources.add(articleModel);

      });
    }
  }
}

class ChannelBasedNews{
  List<ArticleModel> news =[];

  Future<void> getChannelTopNews(String sourceName)async {
    String url ="https://newsapi.org/v2/top-headlines?sources=$sourceName&apiKey=711d9676fe8f414a807b2e686d020e43";

    var response =await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body); 
    if(response.statusCode == 200)
    {
      jsonData["articles"].forEach((element){
       // if(element["urlToImage"]!=null && element["description"]!=null){
        ArticleModel articleModel =  ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          publishedAt: element["publishedAt"],
        );
        news.add(articleModel);
       // }
      });
    }
  }
}