import 'package:flutter/material.dart';

import '../services/utils.dart';

enum Mode { add, remove }

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  var _currentMode = Mode.add;
  final List<bool> _selectedMode = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('tickets'),
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
            tickets(0, Colors.blue.shade800),
            tickets(1, Colors.red.shade800),
            tickets(2, Colors.green.shade800),
            tickets(3, Colors.yellow.shade800),
            tickets(4, Colors.black38),
          ],
        ),
        floatingActionButton: ToggleButtons(
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selectedMode.length; i++) {
                _selectedMode[i] = i == index;
              }
              if (_selectedMode[0]) {
                _currentMode = Mode.add;
              } else {
                _currentMode = Mode.remove;
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderColor: Colors.grey.shade900,          
          selectedBorderColor: Colors.grey.shade900,
          selectedColor: Colors.white,
          fillColor: Colors.black87,  
          color: Colors.grey.shade300,
          disabledColor: Colors.black38,
          isSelected: _selectedMode,
          children: const [
            Icon(Icons.add),
            Icon(Icons.remove),
          ],
        ),
      ),
    );
  }

  void addScore(int index, int value) {
    setState(() {
      ticketsScore[index] += value;
      totalScore[index] += value;
      ticketsHistory[index].add(value);
    });
  }

  void removeScore(int index, int value) {
    setState(() {
      ticketsScore[index] -= value;
      totalScore[index] -= value;
      ticketsHistory[index].add(-value);
    });
  }

  void undo(int index) {
    if (ticketsHistory[index].isNotEmpty) {
      setState(() {
        var lastValue = ticketsHistory[index].removeLast();
        ticketsScore[index] -= lastValue;
        totalScore[index] -= lastValue;
      });
    }
  }

  void clear(int index) {
    setState(() {
      totalScore[index] -= ticketsScore[index];
      ticketsScore[index] = 0;
      ticketsHistory[index].clear();
    });
  }

  Widget tickets(int index, Color color) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Color.fromARGB(180, 0, 0, 0)),
              width: width * 0.9,
              child: Row(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 5,
                      child: Text(
                        'Score:',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.merge(
                              const TextStyle(fontSize: 24),
                            ),
                      )),
                  Expanded(
                      flex: 9,
                      child: Text('${ticketsScore[index]}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.merge(const TextStyle(fontSize: 48)))),
                  const Expanded(flex: 6, child: SizedBox()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(child: _currentMode == Mode.add ? addView(index) : removeView(index)),
          ),
          const Expanded(child: SizedBox())
        ],
      ),
    );
  }

  Widget addView(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  addScore(index, 4);
                },
                child: const Text("+4")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 5);
                },
                child: const Text("+5")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 6);
                },
                child: const Text("+6")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  addScore(index, 7);
                },
                child: const Text("+7")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 8);
                },
                child: const Text("+8")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 9);
                },
                child: const Text("+9")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  addScore(index, 10);
                },
                child: const Text("+10")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 11);
                },
                child: const Text("+11")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 12);
                },
                child: const Text("+12")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  addScore(index, 13);
                },
                child: const Text("+13")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 16);
                },
                child: const Text("+16")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 17);
                },
                child: const Text("+17")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  addScore(index, 20);
                },
                child: const Text("+20")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 21);
                },
                child: const Text("+21")),
            ElevatedButton(
                onPressed: () {
                  addScore(index, 22);
                },
                child: const Text("+22")),
          ],
        ),
      ],
    );
  }

  Widget removeView(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 4);
                },
                child: const Text("-4")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 5);
                },
                child: const Text("-5")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 6);
                },
                child: const Text("-6")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 7);
                },
                child: const Text("-7")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 8);
                },
                child: const Text("-8")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 9);
                },
                child: const Text("-9")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 10);
                },
                child: const Text("-10")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 11);
                },
                child: const Text("-11")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 12);
                },
                child: const Text("-12")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 13);
                },
                child: const Text("-13")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 16);
                },
                child: const Text("-16")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 17);
                },
                child: const Text("-17")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 20);
                },
                child: const Text("-20")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 21);
                },
                child: const Text("-21")),
            ElevatedButton(
                onPressed: () {
                  removeScore(index, 22);
                },
                child: const Text("-22")),
          ],
        ),
      ],
    );
  }
}
