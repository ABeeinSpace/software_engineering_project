import 'package:flutter/material.dart';

class StarmanProvider extends ChangeNotifier {
  bool bowie;

  StarmanProvider({
    this.bowie = false,
  });

  ///toggleIsActive()
  ///Parameters: N/A
  ///Returns: Nothing (void return)
  ///description: Toggles the isActive state on or off
  void toggleIsActive() {
    if (bowie == false) {
      bowie = true;
    } else {
      bowie = false;
    }
    notifyListeners();
  }
}