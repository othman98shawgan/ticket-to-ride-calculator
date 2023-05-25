import 'package:flutter/material.dart';

import '../services/utils.dart';

class BonusesPage extends StatefulWidget {
  const BonusesPage({super.key});

  @override
  State<BonusesPage> createState() => _BonusesPageState();
}

class _BonusesPageState extends State<BonusesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('bonuses'),
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
            bonuses(0, Colors.blue.shade800),
            bonuses(1, Colors.red.shade800),
            bonuses(2, Colors.green.shade800),
            bonuses(3, Colors.yellow.shade800),
            bonuses(4, Colors.black26),
          ],
        ),
      ),
    );
  }

  void addLongestRoad(int index) {
    setState(() {
      bonusesScore[index] += 10;
      totalScore[index] += 10;
    });
  }

  void removeLongest(int index) {
    setState(() {
      bonusesScore[index] -= 10;
      totalScore[index] -= 10;
    });
  }

  void setUsedTrains(int index, int trainsNum) {
    int unUsedTrains = 3 - trainsNum;
    int prevVal = bonusesScore[index];
    prevVal = longestRoad[index] ? prevVal - 10 : prevVal; // decrease longestRoad if needed.

    bonusesScore[index] += unUsedTrains * 4 - prevVal;
    totalScore[index] += unUsedTrains * 4 - prevVal;
  }

  Widget bonuses(int index, Color color) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double height3 = height - padding.top - kToolbarHeight;

    return Container(
      color: color,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: Color.fromARGB(180, 0, 0, 0)),
          width: width * 0.8,
          height: height3 * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  const Expanded(flex: 5, child: Text('Longest road')),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      value: longestRoad[index],
                      onChanged: (value) {
                        setState(() {
                          longestRoad[index] = !longestRoad[index];
                          value ? addLongestRoad(index) : removeLongest(index);
                        });
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  const Expanded(flex: 5, child: Text('Train stations used')),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      value: usedTrainStations[index].toString(),
                      items: <String>['0', '1', '2', '3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          usedTrainStations[index] = int.parse(newValue!);
                          setUsedTrains(index, usedTrainStations[index]);
                        });
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
