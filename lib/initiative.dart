import 'package:software_engineering_project/condition.dart';

class Initiative {
  String name;
  int initiativeCount;
  int? totalHealth;
  int? currentHealth;
  bool shouldElevate = false;
  List<Condition>? conditionsArray = [];

  Initiative({required this.name, required this.initiativeCount, this.totalHealth, this.currentHealth, this.conditionsArray});
    // ;);

  get getName => name;

  set setName( name) => this.name = name;

  get getInitiativeCount => initiativeCount;

  set setInitiativeCount( initiativeCount) => this.initiativeCount = initiativeCount;

  get getTotalHealth => totalHealth;

  set setTotalHealth( totalHealth) => this.totalHealth = totalHealth;

  get getShouldElevate => shouldElevate;

  set setShouldElevate( shouldElevate) => this.shouldElevate = shouldElevate;

  get getCurrentHealth => currentHealth;

  set setCurrentHealth(currentHealth) => this.currentHealth = currentHealth;

  get getConditionsArray => conditionsArray;

  set setConditionsArray( conditionsArray) => this.conditionsArray = conditionsArray;
  
  @override
  String toString() {
    return "$name $initiativeCount $conditionsArray";
  }

}