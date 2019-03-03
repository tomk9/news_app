import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/SourcesModel.dart';
import 'package:news_app/secrets.dart';
import 'package:news_app/widgets/ArticleItem.dart';
import 'package:scoped_model/scoped_model.dart';

class ArticlesList extends StatefulWidget {
  ArticlesList({Key key, this.category, this.country}) : super(key: key);

  final String category;
  final String country;

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  var _sources;
  String _url;

  @override
  void initState() {
    super.initState();
    String _category =
        widget.category == null ? '' : '&category=${widget.category}';
    _url =
        'https://newsapi.org/v2/top-headlines?country=${widget.country}$_category&apiKey=$apiKey';
    _sources = ScopedModel.of<SourcesModel>(context).sources[widget.category];
    if (_sources == null) {
      http.get(_url).then((response) {
        if (response.statusCode == 200) {
          this.setState(() {
            _sources = json.decode(response.body);
          });
          print(_sources);
          ScopedModel.of<SourcesModel>(context)
              .setSources(widget.category, _sources);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _sources == null
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            child: ListView.builder(
              itemCount: _sources['articles'].length,
              itemBuilder: (context, index) {
                return ArticleItem(
                  article: _sources['articles'][index],
                );
              },
            ),
            onRefresh: _onRefresh,
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await http.get(_url).then((response) {
      if (response.statusCode == 200) {
        this.setState(() {
          _sources = json.decode(response.body);
        });
        print(_sources);
        ScopedModel.of<SourcesModel>(context)
            .setSources(widget.category, _sources);
      }
    });
  }
}
