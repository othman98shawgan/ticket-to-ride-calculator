class Player {
  final int id;
  final PlayerColor color;
  final int routesScore;
  final int ticketsScore;
  final int bonusesScore;

  Player(this.id, this.color, this.routesScore, this.ticketsScore, this.bonusesScore);
}

enum PlayerColor {
  blue('Blue'),
  red('Red'),
  green('Green'),
  yellow('Yellow'),
  black('Black');

  const PlayerColor(this.label);
  final String label;
}
