import 'package:software_engineering_project/condition.dart';

class Initiative {
  String name;
  int initiativeCount;
  String? editedName;
  int? editedInitiativeCount;
  int? totalHealth;
  int? currentHealth;
  List<Condition>? conditionsArray = [];
  List<Condition> editedConditionsArray = [
    Condition(
        name: 'Screaming Crying Throwing Up', duration: 10, elapsedTime: 0)
  ];
  bool conditionsChanged = false;

  Initiative(
      {required this.name,
      required this.initiativeCount,
      this.totalHealth,
      this.currentHealth,
      this.conditionsArray,
      this.editedName,
      this.editedInitiativeCount});

  get getName => name;

  setName(name) => this.name = name;

  get getInitiativeCount => initiativeCount;

  setInitiativeCount(initiativeCount) => this.initiativeCount = initiativeCount;

  get getTotalHealth => totalHealth;

  set setTotalHealth(totalHealth) => this.totalHealth = totalHealth;

  get getCurrentHealth => currentHealth;

  set setCurrentHealth(currentHealth) => this.currentHealth = currentHealth;

  get getConditionsArray => conditionsArray;

  setConditionsArray(conditionsArray) => this.conditionsArray = conditionsArray;

  setEditedName(editedName) => this.editedName = editedName;

  setEditedInitiativeCount(editedInitiativeCount) =>
      this.editedInitiativeCount = editedInitiativeCount;

  @override
  String toString() {
    return "$name $initiativeCount $conditionsArray";
  }
}
