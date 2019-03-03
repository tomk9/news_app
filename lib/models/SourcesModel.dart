import 'package:scoped_model/scoped_model.dart';

class SourcesModel extends Model {
  String _key = '';
  Map _sources = {
    '': null,
    'sports': null,
    'technology': null,
  };

  Map get sources => _sources;

  String get lastUpdate => _key;

  void clearSources() {
    _sources = {
      '': null,
      'sports': null,
      'technology': null,
    };
    notifyListeners();
  }

  void setSources(String key, var source) {
    _key = key;
    _sources[key] = source;

    // Then notify all the listeners.
    notifyListeners();
  }
}
