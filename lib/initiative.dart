import 'package:software_engineering_project/condition.dart';

class Initiative implements Comparable<Initiative> {
  String name = "";
  int initiativeCount = 0;
  int totalHealth = 0;
  int currentHealth = 0;
  late List<Condition> conditionsArray = initConditionsArray();

  Initiative({
    required String name,
    required String initiativeCount,
    int? totalHealth,
    int? currentHealth,
  });

  List<Condition> initConditionsArray() {
    conditionsArray.add(Condition(name: "Blinded", duration: 10, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Frightened", duration: 5, elapsedTime: 2));
    conditionsArray.add(Condition(name: "Exhaustion", duration: 7, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Restrained", duration: 12, elapsedTime: 4));
    return conditionsArray;
  }

  get getName => name;

  set setName( name) => this.name = name;

  get getInitiativeCount => initiativeCount;

  set setInitiativeCount( initiativeCount) => this.initiativeCount = initiativeCount;

  get getTotalHealth => totalHealth;

  set setTotalHealth( totalHealth) => this.totalHealth = totalHealth;

  get getCurrentHealth => currentHealth;

  set setCurrentHealth(currentHealth) => this.currentHealth = currentHealth;

  get getConditionsArray => conditionsArray;

  set setConditionsArray( conditionsArray) => this.conditionsArray = conditionsArray;
  
  @override
  int compareTo(Initiative other) {
    if (initiativeCount < other.initiativeCount) {
      return -1;
    } else if (initiativeCount > other.initiativeCount) {
      return 1;
    } else {
      return 0;
    }

  }


}