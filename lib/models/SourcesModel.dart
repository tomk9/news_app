import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/secrets.dart';

class SourcesModel extends Model {
  SourcesModel() {
    http
        .get('https://newsapi.org/v2/top-headlines?country=pl&apiKey=$apiKey')
        .then((response) {
      if (response.statusCode == 200) {
        _sources[0] = json.decode(response.body);
        print(sources);
        notifyListeners();
      }
    });
  }

  String _key = '';
  Map _sources = {
    '': null,
    'sports': null,
    'technology': null,
  };

  Map get sources => _sources;
  String get lastUpdate => _key;

  void setSources(String key, var source) {
    _key = key;
    _sources[key] = source;

    // Then notify all the listeners.
    notifyListeners();
  }
}
