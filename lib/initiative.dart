import 'package:software_engineering_project/condition.dart';

class Initiative {
  String name;
  int initiativeCount;
  String? editedName;
  int? editedInitiativeCount;
  int? totalHealth;
  int? currentHealth;
  int? editedTotalHealth;
  int? editedCurrentHealth;
  List<Condition> conditionsArray = [];

  bool conditionsChanged = false;
  bool toBeDeleted = false;

  Initiative(
      {required this.name,
      required this.initiativeCount,
      this.totalHealth,
      this.currentHealth,
      required this.conditionsArray,
      this.editedName,
      this.editedInitiativeCount});

  get getName => name;

  setName(name) => this.name = name;

  get getInitiativeCount => initiativeCount;

  setInitiativeCount(initiativeCount) => this.initiativeCount = initiativeCount;

  get getTotalHealth => totalHealth;

  setTotalHealth(totalHealth) => this.totalHealth = totalHealth;

  setEditedTotalHealth(editedTotalHealth) =>
      this.editedTotalHealth = editedTotalHealth;

  get getCurrentHealth => currentHealth;

  setCurrentHealth(currentHealth) => this.currentHealth = currentHealth;

  setEditedCurrentHealth(editedCurrentHealth) =>
      this.editedCurrentHealth = editedCurrentHealth;

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
