
class Initative implements Comparable<Initative> {
  String name = "";
  int initiativeCount = 999;
  int totalHealth = 0;
  int currentHealth = 0;
  var conditionsArray;

  Initative({
    required String name,
    required int initiativeCount,
    int? totalHealth,
    int? currentHealth,
    var conditionsArray
  });

  get getName => name;

  set setName( name) => this.name = name;

  get getInitiativeCount => initiativeCount;

  set setInitiativeCount( initiativeCount) => this.initiativeCount = initiativeCount;

  get getTotalHealth => totalHealth;

  set setTotalHealth( totalHealth) => this.totalHealth = totalHealth;

  get getCurrentHealth => currentHealth;

  set setCurrentHealth( currentHealth,) => this.currentHealth = currentHealth;

  get getConditionsArray => conditionsArray;

  set setConditionsArray( conditionsArray) => this.conditionsArray = conditionsArray;
  
  @override
  int compareTo(Initative other) {
    if (initiativeCount < other.initiativeCount) {
      return -1;
    } else if (initiativeCount > other.initiativeCount) {
      return 1;
    } else {
      return 0;
    }

  }


}