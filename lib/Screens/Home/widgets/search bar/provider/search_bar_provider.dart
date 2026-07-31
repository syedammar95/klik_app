import 'package:flutter/material.dart';

class SearchBarProvider with ChangeNotifier {
  String _searchQuery = "";

  String get searchQuery => _searchQuery;

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
