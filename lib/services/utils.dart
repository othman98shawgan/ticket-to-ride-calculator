import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String str) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
}

List<int> usedTrains = List.filled(5, 0, growable: true);
List<int> totalScore = List.filled(5, 0, growable: true);
List<int> routesScore = List.filled(5, 0, growable: true);
List<int> ticketsScore = List.filled(5, 0, growable: true);
List<int> bonusesScore = List.filled(5, 12, growable: true);
List<int> usedTrainStations = List.filled(5, 0, growable: true);
List<bool> longestRoad = List.filled(5, false, growable: true);
List<List<int>> routesHistory = List.generate(5, (_) => List.empty(growable: true));
List<List<int>> ticketsHistory = List.generate(5, (_) => List.empty(growable: true));
