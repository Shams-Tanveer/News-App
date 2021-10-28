import 'package:flutter/material.dart';
import 'package:news_app/Models/article_model.dart';
import 'package:news_app/Models/countrymodel.dart';
import 'package:news_app/Services/newarticle.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'article_view.dart';

class SearchNews extends StatefulWidget {
  final String searchedValue;
  SearchNews({required this.searchedValue});

  @override
  _SearchNewsState createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
    List<ArticleModel> articles =<ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchedNews();
  }

    getSearchedNews()
  async {
    SearchedBasedNews newsList =  SearchedBasedNews();
    await newsList.getSearchedNews(widget.searchedValue);
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
          padding: const EdgeInsets.only(right:70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Country.name,style: TextStyle(color: Colors.blue.shade900),),
              Text("TopNews",style: TextStyle(color: Colors.red.shade900),),
          ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        ),
        body: _loading ?  Container(child: Center(child: CircularProgressIndicator()),)
        :SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
            Container(
                  padding: EdgeInsets.only(top:16),
                  child:ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder:(context,index){
                      return NewsTile(
                        imageUrl: articles[index].urlToImage ?? "https://icoconvert.com/images/noimage2.png",
                        title: articles[index].title!,
                        description: articles[index].description ?? "",
                        url: articles[index].url!,
                        time: articles[index].publishedAt!,
                      );
                    }
                    ) ,
                ),
          ],
          ),
          ),
        ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl,title,description,url,time;
  NewsTile({required this.imageUrl,required this.title,required this.description,required this.url,required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ArticleView(articleViewUrl: url,)));
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
            ClipRRect(child: Image.network(imageUrl),
            borderRadius: BorderRadius.circular(6),),
             SizedBox( height: 8),
            Padding(
              padding: const EdgeInsets.only(left:250.0),
              child: Text(timeago.format(DateTime.parse(time)), style: const TextStyle(color: Colors.black87, fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            SizedBox( height: 8),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Text(title,style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            SizedBox( height: 8),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Text(description,style: TextStyle( fontSize: 16,color: Colors.black54),),
            ),
          ],),
      ),
    );
  }
}