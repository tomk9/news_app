import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app/models/SourcesModel.dart';
import 'package:news_app/screens/ArticlesList.dart';
import 'package:news_app/secrets.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SourcesModel _sourcesModel = SourcesModel();
  PageController _pageController;
  int _page = 0;
  String _title = 'PL';
  var _sources;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SourcesModel>(
      model: _sourcesModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${_title.toUpperCase()}'),
        ),
        drawer: FractionallySizedBox(
          widthFactor: (sqrt(5) - 1) / 2,
          child: Drawer(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 5,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (_title != 'PL') {
                        _sourcesModel.clearSources();
                      }
                      setState(() {
                        _title = 'PL';
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'icons/flags/png/pl.png',
                                  package: 'country_icons',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              'PL',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 5,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (_title != 'US') {
                        _sourcesModel.clearSources();
                      }
                      setState(() {
                        _title = 'US';
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'icons/flags/png/us.png',
                                  package: 'country_icons',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'US',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          children: <Widget>[
            ArticlesList(
              key: UniqueKey(),
              country: _title,
            ),
            ArticlesList(
              key: UniqueKey(),
              country: _title,
              category: 'sports',
            ),
            ArticlesList(
              key: UniqueKey(),
              country: _title,
              category: 'technology',
            ),
          ],
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.newspaper),
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.soccer),
              title: Text('Sports'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.laptop),
              title: Text('Technology'),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    http
        .get('https://newsapi.org/v2/top-headlines?country=pl&apiKey=$apiKey')
        .then((response) {
      if (response.statusCode == 200) {
        _sources = json.decode(response.body);
        print(_sources);
      }
    });
    _sourcesModel.setSources('', _sources);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
