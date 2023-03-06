class Condition implements Comparable<Condition> {
  String name;
  int duration;
  int? elapsedTime;
  
  Condition({required this.name, required this.duration, this.elapsedTime});
  
  
  get getName => name;

  set setName( name) => this.name = name;

  get getDuration => duration;

  set setDuration( duration) => this.duration = duration;

  get getElapedTime => elapsedTime;

  set setElapedTime( elapedTime) => elapsedTime = elapedTime;
  
  @override
  int compareTo(Condition other) {
    throw UnimplementedError();
  }

  @override
  String toString() {
    return "$name $duration $elapsedTime";
  }
}

