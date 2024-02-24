import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:make_my_life/action/gamblling.dart';
import 'package:make_my_life/share.dart';
import '../common/myButton.dart';
import '../common/myWord.dart';
import 'dart:math' as math;

/// ゲームメイン
class GamblingPage extends StatefulWidget {
  GamblingPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<GamblingPage> createState() => _GamblingPageState();
}

Size viewSize = new Size(0, 0);

class _GamblingPageState extends State<GamblingPage> {
  @override
  Widget build(BuildContext context) {
    final MyGambling myGambling = MyGambling(context);
    viewSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("ギャンブル画面"),
        leadingWidth: 50, //leadingWidthを設定する
        leading: TextButton(
          child: Text(
            'キャンセル',
            style: TextStyle(
              color: Colors.black, //文字の色を白にする
              fontWeight: FontWeight.bold, //文字を太字する
              fontSize: 12.0, //文字のサイズを調整する
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GameWidget(
          game: myGambling,
        ),
      ),
    ));
  }
}

class MyGambling extends FlameGame {
  // ***********************************************
  // *
  // *	定数宣言
  // *
  // ***********************************************

  // 背景
  MyWorld? myWorld = null;

  // 競馬ボタン
  MyButton? horseRacingButton = null;

  // ビルドコンテキスト
  final BuildContext _buildContext;

  // ***********************************************
  // *
  // *	コンストラクタ
  // *
  // ***********************************************
  MyGambling(this._buildContext) : super();

  // ***********************************************
  // *
  // *	ロード処理
  // *
  // ***********************************************
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 背景を追加
    myWorld = MyWorld('back.png', viewSize);
    await add(world!);

    // 競馬ボタンを追加する
    horseRacingButton = MyButton(
        "mushi.png", "mushi.png", "\n競馬", Vector2.all(100.0), onPressed);
    horseRacingButton!.GetPos(new Vector2(viewSize.width / 2, 500));
    horseRacingButton!.GetAnchor(Anchor.bottomCenter);
    await add(horseRacingButton!);
  }

  // ***********************************************
  // *
  // *	メソッド
  // *
  // ***********************************************
  void onPressed(String type) async {
    print("ボタンクリック内容");
    print(type);

    switch (type) {
      case "\n競馬":
        var random = math.Random();
        Gambling gambling = Gambling();
        // オッズをランダムに生成
        List<int> odds = gambling.generateOdds();
        int rand = random.nextInt(5);
        // 競馬処理を実行
        int getValue = gambling.doHorseRacing(odds[rand]);
        print(getValue);

        // データ保存用インスタンス生成
        Share share = Share();
        // 月カウンターをインクリメント
        await share.setCounter();
        // 設定情報を取得
        await share.getSetting();
        print(share.date_counter);
        print(share.rate);
        break;
      default:
    }
  }
}
