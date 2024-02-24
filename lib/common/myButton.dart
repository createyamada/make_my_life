// import 'dart:math' as math;
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';

import 'myUiImage.dart';
import 'myText.dart';

/// ボタンを用意する
class MyButton extends PositionComponent with HasGameRef {
  // 適応させる座標系
  PositionType posType = PositionType.viewport;
  // 押された時の画像パス
  String pressedImagePath = "";
  // 押されてない時の画像パス
  String unpressedImagePath = "";
  // ボタンテキスト
  String buttonString = "";
  // スプライトサイズ
  Vector2 spritSize = Vector2(32.0, 32.0);
  // ボタンコンポーネント
  ButtonComponent? buttonComponent = null;
  // ボタンを押した時の処理
  Function? onPushPressed;
  // ボタンスプライト
  MyUIImage? pressedSprite;
  // ボタンスプライト
  MyUIImage? unpressedSprite;
  // ボタンテキスト
  MyText? buttonText;

  // コンストラクタ
  MyButton(this.pressedImagePath, this.unpressedImagePath, this.buttonString,
      this.spritSize, this.onPushPressed,
      {this.posType = PositionType.viewport});

  /// 読み込み処理
  ///
  @override
  Future<void>? onLoad() async {
    posType = posType;
    // ボタン画像の設定
    pressedSprite = MyUIImage(pressedImagePath, spritSize);
    pressedSprite!.position = Vector2.zero();
    unpressedSprite = MyUIImage(unpressedImagePath, spritSize);
    unpressedSprite!.position = Vector2.zero();

    // ボタンを作成する
    buttonComponent = new ButtonComponent(
      button: pressedSprite,
      //　押したときにボタンの画像を変化させる処理を使うとエラーになるので使わない
      //     buttonDown: unpressedSprite,
      onPressed: onPushButton,
      size: spritSize,
      position: Vector2.zero(),
    );
    // buttonComponent!.positionType = posType;

    size = spritSize;

    buttonText = MyText(
        new TextBoxConfig(
          maxWidth: 300,
        ),
        posType);
    SetText();

    add(buttonComponent!);
    add(buttonText!);

    await super.onLoad();
  }

  /// 更新処理
  @override
  void update(double dt) {
    super.update(dt);
  }

  /// 座標を変更する
  /// [pos] Vector2型の座標
  void GetPos(Vector2 pos) {
    position = pos;
  }

  /// サイズを設定する
  void GetSize(Vector2 newSize) {
    size = newSize;
  }

  /// anchor設定する
  void GetAnchor(Anchor newAnchor) {
    anchor = newAnchor;
  }

  /// テキストを変更する
  void SetText() {
    buttonText!.SetText(buttonString, Colors.white, 21.0);
    buttonText!.GetPos(new Vector2(10, 0));
  }

  // ボタンを押された時
  void onPushButton() {
    if (onPushPressed != null) {
      onPushPressed!(this.buttonString);
    }
  }
}
