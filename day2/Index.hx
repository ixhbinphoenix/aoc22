class Index {
  static public function main() {
    var content:String = sys.io.File.getContent('./input.txt');
    var lines = content.split('\n');

    var points:Int = 0;
    for (line in lines) {
      
      var moves = line.split(' ');

      var enemyMove = switch moves[0] {
        case "A": Rock;
        case "B": Paper;
        case "C": Scissors;
        case _:
          continue;  
      }

      var solutionMove = switch moves[1] {
        case "X": Rock;
        case "Y": Paper;
        case "Z": Scissors;
        case _:
          throw "This is not XYZ";
      }

      var outcomePoints = switch [solutionMove, enemyMove] {
        case [Rock, Scissors] | [Paper, Rock] | [Scissors, Paper]: 6;
        case [Rock, Paper] | [Paper, Scissors] | [Scissors, Rock]: 0;
        case _: 3;
      }

      var movePoints = switch solutionMove {
        case Rock: 1;
        case Paper: 2;
        case Scissors: 3;
      }

      points = points + movePoints + outcomePoints;
    }
    trace('Part 1: $points');

    points = 0;
    for (line in lines) {
      var moves = line.split(" ");

      var enemyMove = switch moves[0] {
        case "A": Rock;
        case "B": Paper;
        case "C": Scissors;
        case _:
          continue;
      }
      switch moves[1] { 
        case "X":
          //Lose
          switch enemyMove {
            // Pick Scissors and lose
            case Rock: points += 3;
            // Pick Rock and lose
            case Paper: points += 1;
            // Pick Paper and lose
            case Scissors: points += 2;
          }
        case "Y":
          //Draw
          switch enemyMove {
            case Rock: points += 1 + 3;
            case Paper: points += 2 + 3;
            case Scissors: points += 3 + 3;
          }
        case "Z":
          // Win
          switch  enemyMove {
            // Pick Paper and win
            case Rock: points += 2 + 6;
            // Pick Scissors and win
            case Paper: points += 3 + 6;
            // Pick Rock and win
            case Scissors: points += 1 + 6;
          }
      }
    }
    trace('Part 2: $points');
  }
}

enum Move {
  Rock;
  Paper;
  Scissors;
}

enum Result {
  Win;
  Loss;
  Draw;
}
