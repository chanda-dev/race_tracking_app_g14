import 'package:flutter/material.dart';

class DropDownProvider extends ChangeNotifier {
  String? _activeCardId;
  String? get activeCardId => _activeCardId;

  void toggleCard(String id) {
    if (_activeCardId == id) {
      _activeCardId = null;
    } else {
      _activeCardId = id;
    }
    notifyListeners();
  }
}
