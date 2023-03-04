import 'package:flutter/material.dart';

class Condition implements Comparable<Condition> {
  String name = "";
  int duration = 0;
  int elapsedTime = 0;
  
  Condition({
    required String name,
    required int duration,
    required int elapsedTime
    });
  
  
  get getName => name;

  set setName( name) => this.name = name;

  get getDuration => duration;

  set setDuration( duration) => this.duration = duration;

  get getElapedTime => elapsedTime;

  set setElapedTime( elapedTime) => this.elapsedTime = elapedTime;
  
  @override
  int compareTo(Condition other) {
    throw UnimplementedError();
  }
}

