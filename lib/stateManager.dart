import 'package:flutter/material.dart';
// import 'initiative_card.dart';
// import 'initiative.dart';

class StateManager extends ChangeNotifier {
  bool isActive = false;

  void toggleIsActive() {    
    if (isActive = true) {
      isActive = false;
    } else {
      isActive = true;
    }
    notifyListeners();
  }
  bool get getIsActive => this.isActive;

  set setIsActive(bool isActive) => this.isActive = isActive;

}