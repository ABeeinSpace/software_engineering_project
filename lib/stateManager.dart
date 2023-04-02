import 'package:flutter/material.dart';
import 'package:software_engineering_project/initiative_card.dart';

class StateManager extends ChangeNotifier {
  bool isActive;

  StateManager({
    this.isActive = true,
  });

  ///toggleIsActive()
  ///Parameters: N/A
  ///Returns: Nothing (void return)
  ///description: Toggles the isActive state on or off
  void toggleIsActive() {
    if (isActive == false) {
      isActive = true;
    } else {
      isActive = false;
    }
    notifyListeners();
  }
}