import 'package:flutter/material.dart';
import 'package:software_engineering_project/stateless_initiative_card.dart';
// import 'initiative_card.dart';
// import 'initiative.dart';

class StateManager extends ChangeNotifier {
  bool isActive;

  StateManager({
    this.isActive = false,
  });

  void toggleIsActive() {
    if (isActive == false) {
      isActive = true;
    } else {
      isActive = false;
    }
    notifyListeners();
  }
}