import 'dart:math' as math;

class Gambling {
  // 結果を返す変数
  int? result = null;
  int? bet = 1000;

  /**
	* 競馬を行う処理
	* @param int odds
	* @return result
	*/
  int doHorseRacing(int odds) {
    var random = math.Random();
    int rand = random.nextInt(1000);

    if (odds <= 3 && random.nextInt(3) == random.nextInt(3)) {
      // オッズが2倍以内の当選時
      return bet! * odds;
    } else if (odds >= 4 &&
        odds <= 6 &&
        random.nextInt(5) == random.nextInt(5)) {
      return bet! * odds;
    } else if (odds >= 7 &&
        odds <= 13 &&
        random.nextInt(10) == random.nextInt(10)) {
      return bet! * odds;
    } else if (odds >= 14 &&
        odds <= 32 &&
        random.nextInt(27) == random.nextInt(27)) {
      return bet! * odds;
    } else if (odds >= 33 &&
        odds <= 80 &&
        random.nextInt(67) == random.nextInt(67)) {
      return bet! * odds;
    } else if (odds >= 81 &&
        odds <= 1000 &&
        random.nextInt(334) == random.nextInt(334)) {
      return bet! * odds;
    }
    return 0;
  }

  /**
	* 競馬のオッズを生成する処理
	* @param null
	* @return List<int> odds
	*/
  List<int> generateOdds() {
    var random = math.Random();
    int one = random.nextInt(1000) + 81;
    int two = random.nextInt(80) + 33;
    int three = random.nextInt(32) + 14;
    int four = random.nextInt(13) + 7;
    int five = random.nextInt(6) + 4;
    int six = random.nextInt(3);

    List<int> odds = [one, two, three, four, five, six];

    return odds;
  }
}
