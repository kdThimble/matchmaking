import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  String _categoryId = "";
  String _title = "";
  String _brief = "";
  String _city = "";
  String _state = "";
  String _zipCode = "";
  double _minBudget = 0.0;
  double _maxBudget = 0.0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  String get categoryId => _categoryId;
  set categoryId(String value) {
    _categoryId = value;
    print("category id set");
    notifyListeners();
  }

  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get brief => _brief;
  set brief(String value) {
    _brief = value;
    notifyListeners();
  }

  String get city => _city;
  set city(String value) {
    _city = value;
    notifyListeners();
  }

  String get state => _state;
  set state(String value) {
    _state = value;
    notifyListeners();
  }

  String get zipCode => _zipCode;
  set zipCode(String value) {
    _zipCode = value;
    notifyListeners();
  }

  double get minBudget => _minBudget;
  set minBudget(double value) {
    _minBudget = value;
    notifyListeners();
  }

  double get maxBudget => _maxBudget;
  set maxBudget(double value) {
    _maxBudget = value;
    notifyListeners();
  }

  DateTime get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime get endDate => _endDate;
  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }
}
