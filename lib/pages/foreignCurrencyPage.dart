import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../common/myButton.dart';
import '../common/myWord.dart';

/// ゲームメイン
class ForeignCurrencyPage extends StatefulWidget {
  ForeignCurrencyPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<ForeignCurrencyPage> createState() => _ForeignCurrencyPageState();
}

Size viewSize = new Size(0, 0);

class _ForeignCurrencyPageState extends State<ForeignCurrencyPage> {
  @override
  Widget build(BuildContext context) {
    final MyForeignCurrency myForeignCurrency = MyForeignCurrency(context);
    viewSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("外貨売買画面"),
        leadingWidth: 85,
        leading: TextButton(
          child: Text(
            'キャンセル',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GameWidget(
          game: myForeignCurrency,
        ),
      ),
    ));
  }
}

class MyForeignCurrency extends FlameGame {
  // ***********************************************
  // *
  // *	定数宣言
  // *
  // ***********************************************

  // 背景
  MyWorld? myWorld = null;

  // 外貨購入ボタン
  MyButton? foreignCurrencyUpButton = null;

  // 外貨売却ボタン
  MyButton? foreignCurrencyDownButton = null;

  // ビルドコンテキスト
  final BuildContext _buildContext;

  // ***********************************************
  // *
  // *	コンストラクタ
  // *
  // ***********************************************
  MyForeignCurrency(this._buildContext) : super();

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

    // 外貨購入ボタンを追加する
    foreignCurrencyUpButton = MyButton(
        "shiba.png", "mushi.png", "\n外貨購入", Vector2.all(100.0), onPressed);
    foreignCurrencyUpButton!.GetPos(new Vector2(viewSize.width / 2 - 100, 500));
    foreignCurrencyUpButton!.GetAnchor(Anchor.bottomCenter);
    await add(foreignCurrencyUpButton!);

    // 外貨売却ボタンを追加する
    foreignCurrencyDownButton = MyButton(
        "shiba.png", "mushi.png", "\n外貨売却", Vector2.all(100.0), onPressed);
    foreignCurrencyDownButton!
        .GetPos(new Vector2(viewSize.width / 2 + 100, 500));
    foreignCurrencyDownButton!.GetAnchor(Anchor.bottomCenter);
    await add(foreignCurrencyDownButton!);
  }

  // ***********************************************
  // *
  // *	メソッド
  // *
  // ***********************************************
  void onPressed(String type) {
    print("ボタンクリック内容");
    print(type);

    switch (type) {
      case "\n外貨購入":
        print("外貨購入");

        break;

      case "\n外貨売却":
        print("外貨売却");

        break;
      default:
    }
  }
}
