import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  ArticleWebView({Key key, this.article}) : super(key: key);

  final article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
      ),
      body: WebView(
        initialUrl: article['url'],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
