import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/secrets.dart';
import 'package:news_app/widgets/ArticleItem.dart';

class ArticlesList extends StatefulWidget {
  ArticlesList({Key key, this.category, this.country}) : super(key: key);

  final String category;
  final String country;

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  var sources;

  @override
  void initState() {
    super.initState();
    String _category =
        widget.category == null ? '' : '&category=${widget.category}';
    final String _url =
        'https://newsapi.org/v2/top-headlines?country=${widget.country}$_category&apiKey=$apiKey';
    if (sources == null) {
      http.get(_url).then((response) {
        if (response.statusCode == 200) {
          this.setState(() {
            sources = json.decode(response.body);
          });
          print(sources);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return sources == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: sources['articles'].length,
            itemBuilder: (context, index) {
              return ArticleItem(
                article: sources['articles'][index],
              );
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
