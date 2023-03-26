import 'package:flutter/material.dart';
import 'package:software_engineering_project/initiative_card.dart';
// import 'initiative_card.dart';
// import 'initiative.dart';

class ElevationProvider extends ChangeNotifier {
  double elevation;

  ElevationProvider({
    this.elevation = 3
  });

  void toggleElevation(InitiativeCardContainer cardContainer) {
    if (elevation == 3.0) {
      elevation = 15.0;
    } else {
      elevation = 3.0;
    }
    notifyListeners();
  }
}