import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:news_app/screens/ArticleWebView.dart';

class ArticleItem extends StatelessWidget {
  ArticleItem({Key key, this.article}) : super(key: key);

  final article;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.25,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleWebView(
                    article: article,
                  ),
            ),
          );
        },
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                        Positioned.fill(
                          child: article['urlToImage'] == null
                              ? Container(
                                  color: Colors.blueGrey,
                                )
                              : FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: article['urlToImage'],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    article['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
