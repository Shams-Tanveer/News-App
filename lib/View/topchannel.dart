

import 'package:flutter/material.dart';
import 'package:news_app/Models/countrymodel.dart';
import 'package:news_app/Models/sourcemodel.dart';
import 'package:news_app/Services/newarticle.dart';
import 'package:flutter/src/rendering/box.dart';
import 'dart:io' as io;
import 'channelbasedtopnews.dart';
import 'home.dart';
late final String imageUrl;

class TopChannel extends StatefulWidget {
  const TopChannel({ Key? key }) : super(key: key);

  @override
  _TopChannelState createState() => _TopChannelState();
}

class _TopChannelState extends State<TopChannel> {
 List<SourceModel> sources = <SourceModel>[];
 bool _loading = true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getTopChannel();
  }
   getTopChannel() async {
    Source sourceList = Source();
    await sourceList.getTopSource();
    sources = sourceList.sources;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
            },
            child: Container(
              color: Colors.grey,
              height: 50,
              width: MediaQuery.of(context).size.width/2.25,
              child: Center(child: Text("Top Country News",style: TextStyle(color:Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              color: Colors.lightBlueAccent,
              height: 50,
              width: MediaQuery.of(context).size.width/1.8,
              child: Center(child: Text("Top Channel",style: TextStyle(color:Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right:70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Country.name,
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
      body:_loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.only(top:16),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2 ,
              crossAxisSpacing: 4, 
              ),
              itemCount: sources.length, 
            itemBuilder: (context,index){
              return NewsTile(
                id: sources[index].id,
                name: sources[index].name,
                );
            }
            ),
          ),
          ),
    );
  }
}


class NewsTile extends StatelessWidget {
  final String? id;final String? name;
  NewsTile(
      { this.id,
      this.name,});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChannelTopNews(
                      sourceName: id ?? "",
                    )));
      },
      child: Container(
        //  padding: EdgeInsets.only(bottom: 16),
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
              child: Image.asset("assets/$id.png" ,width: double.infinity,height: 100,),
              borderRadius: BorderRadius.circular(6),
            ),
            
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                name ?? "",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),     
          ],
        ),
      ),
    );
  }
}
