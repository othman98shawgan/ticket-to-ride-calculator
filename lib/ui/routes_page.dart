import 'package:flutter/material.dart';

import '../services/utils.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  int avaliableTrains = 45;
  var socreMap = {
    1: 1,
    2: 2,
    3: 4,
    4: 7,
    5: 15,
    6: 21,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('routes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Blue'),
              Tab(text: 'Red'),
              Tab(text: 'Green'),
              Tab(text: 'Yellow'),
              Tab(text: 'Black'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            routes(0, Colors.blue.shade800),
            routes(1, Colors.red.shade800),
            routes(2, Colors.green.shade800),
            routes(3, Colors.yellow.shade800),
            routes(4, Colors.black26),
          ],
        ),
      ),
    );
  }

  void addScore(int index, int value) {
    if (avaliableTrains - usedTrains[index] - value >= 0) {
      setState(() {
        usedTrains[index] += value;
        routesScore[index] += socreMap[value]!;
        totalScore[index] += socreMap[value]!;
        routesHistory[index].add(value);
      });
    } else {
      showSnackBar(context, 'Not enough trains left, GameOver!');
    }
  }

  void undo(int index) {
    if (routesHistory[index].isNotEmpty) {
      setState(() {
        var removedValue = routesHistory[index].removeLast();
        usedTrains[index]-= removedValue;
        var lastValue = socreMap[removedValue]!;
        routesScore[index] -= lastValue;
        totalScore[index] -= lastValue;
      });
    }
  }

  void clear(int index) {
    setState(() {
      totalScore[index] -= routesScore[index];
      usedTrains[index] = 0;
      routesScore[index] = 0;
      routesHistory[index].clear();
    });
  }

  Widget routes(int index, Color color) {

    double width = MediaQuery.of(context).size.width;

    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child:
                          Text('Used Trains - ${usedTrains[index]}', textAlign: TextAlign.center)),
                  Expanded(
                      child: Text('Available Trains - ${avaliableTrains - usedTrains[index]}',
                          textAlign: TextAlign.center)),
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Color.fromARGB(180, 0, 0, 0)),
              width: width * 0.9,
              child: Center(
                child: Text('Score - ${routesScore[index]}',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.merge(const TextStyle(fontSize: 36))),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 1);
                        },
                        child: const Text("1")),
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 2);
                        },
                        child: const Text("2")),
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 3);
                        },
                        child: const Text("3")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 4);
                        },
                        child: const Text("4")),
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 5);
                        },
                        child: const Text("5")),
                    ElevatedButton(
                        onPressed: () {
                          addScore(index, 6);
                        },
                        child: const Text("6")),
                  ],
                )
              ],
            )),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => undo(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  child: const Icon(Icons.undo_rounded),
                ),
                ElevatedButton(
                  onPressed: () => clear(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
