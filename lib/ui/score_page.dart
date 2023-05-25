import 'package:flutter/material.dart';
import 'package:ticket_to_ride_calculator/models/player.dart';
import 'package:ticket_to_ride_calculator/services/utils.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  var colorMap = {
    PlayerColor.blue: Colors.blue.shade800,
    PlayerColor.red: Colors.red.shade800,
    PlayerColor.green: Colors.green.shade800,
    PlayerColor.yellow: Colors.yellow.shade800,
    PlayerColor.black: Colors.black54,
  };

  var getTotlaScore =
      ((Player player) => player.bonusesScore + player.routesScore + player.ticketsScore);

  final List<Player> players = [
    Player(0, PlayerColor.blue, routesScore[0], ticketsScore[0], bonusesScore[0]),
    Player(1, PlayerColor.red, routesScore[1], ticketsScore[1], bonusesScore[1]),
    Player(2, PlayerColor.green, routesScore[2], ticketsScore[2], bonusesScore[2]),
    Player(3, PlayerColor.yellow, routesScore[3], ticketsScore[3], bonusesScore[3]),
    Player(4, PlayerColor.black, routesScore[4], ticketsScore[4], bonusesScore[4])
  ];

  void sortPlayers() {
    players.sort((playerA, playerB) {
      int compare = getTotlaScore(playerB).compareTo(getTotlaScore(playerA));
      if (compare == 0) {
        compare = ticketsHistory[playerB.id].length.compareTo(ticketsHistory[playerA.id].length);
      }
      if (compare == 0) {
        compare = usedTrainStations[playerA.id].compareTo(usedTrainStations[playerB.id]);
      }
      if (compare == 0) {
        compare = longestRoad[playerA.id]
            ? 1
            : longestRoad[playerB.id]
                ? -1
                : 0;
      }
      if (compare == 0) {
        // showSnackBar(context, '${playerA.color.label} and ${playerB.color.label} have drawed');
      }
      return compare;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Full screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    // Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;

    var headerTextStyle = const TextStyle(fontStyle: FontStyle.italic, fontSize: 14);

    sortPlayers();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Socre'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  usedTrains = List.filled(5, 0);
                  totalScore = List.filled(5, 0);
                  routesScore = List.filled(5, 0);
                  ticketsScore = List.filled(5, 0);
                  bonusesScore = List.filled(5, 12);
                  usedTrainStations = List.filled(5, 0);
                  longestRoad = List.filled(5, false);
                  routesHistory = List.generate(5, (_) => List.empty(growable: true));
                  ticketsHistory = List.generate(5, (_) => List.empty(growable: true));
                });
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height3 * 0.1,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(
                      width: 1.0,
                      color: Colors.white,
                    ),
                    headingTextStyle: headerTextStyle,
                    columnSpacing: width / 15,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text('Player'),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Routes'),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Tickets'),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Bonuses'),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Total'),
                        ),
                      )
                    ],
                    rows: players.map((player) {
                      return DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            return colorMap[player.color];
                          }),
                          cells: [
                            DataCell(Text(player.color.label)),
                            DataCell(Text(player.routesScore.toString())),
                            DataCell(Text(player.ticketsScore.toString())),
                            DataCell(Text(player.bonusesScore.toString())),
                            DataCell(Text(getTotlaScore(player).toString())),
                          ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
