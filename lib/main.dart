import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app/screens/ArticlesList.dart';

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
  var sources;
  PageController _pageController;
  int _page = 0;
  String _title = 'PL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_title.toUpperCase()}'),
      ),
      drawer: Drawer(
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
                        child: SvgPicture.asset(
                          'icons/flags/svg/pl.svg',
                          package: 'country_icons',
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
                        child: Image.asset(
                          'icons/flags/png/2.5x/us.png',
                          package: 'country_icons',
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
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
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
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
