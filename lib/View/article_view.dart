import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  final String articleViewUrl;

  ArticleView({required this.articleViewUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
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
              Text("Canada",style: TextStyle(color: Colors.blue.shade900),),
              Text("TopNews",style: TextStyle(color: Colors.red.shade900),),
          ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        ),
      body: Container(
        child: WebView(
          initialUrl: widget.articleViewUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}