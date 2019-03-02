import 'package:scoped_model/scoped_model.dart';

class CountryModel extends Model {
  String _country = 'pl';

  String get country => _country;

  void setCountry(String country) {
    _country = country;

    // Then notify all the listeners.
    notifyListeners();
  }
}