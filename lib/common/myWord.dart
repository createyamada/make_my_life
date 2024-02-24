// import 'dart:math' as math;
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'myUiImage.dart';

/// 背景を用意する
class MyWorld extends PositionComponent with HasGameRef {
  // 適応させる座標系
  PositionType posType = PositionType.viewport;
  // 背景の画像パス
  String ImagePath = "";
  // 画像のサイズ
  Size? viewSize = null;
  // 画像位置
  Vector2? posi = null;
  // 背景
  MyUIImage? world = null;

  Sprite? sprite = null;
  

  // コンストラクタ
  MyWorld(this.ImagePath,this.viewSize,
      {this.posType = PositionType.viewport});

  /// 読み込み処理
  ///
  @override
  Future<void>? onLoad() async {
    size = Vector2(viewSize!.width , viewSize!.height);
    sprite = await Sprite.load('back.png');
    world = MyUIImage(ImagePath , sprite!.originalSize);
    world!.position = Vector2(viewSize!.width / 2 - sprite!.originalSize.x / 2 , viewSize!.height / 2 - sprite!.originalSize.y / 2 );
    add(world!);
    await super.onLoad();
  }

  /// 更新処理
  @override
  void update(double dt) {
    super.update(dt);
  }


  /// サイズを設定する
  void GetSize(Vector2 newSize) {
    size = newSize;
  }

  /// 座標を取得する
  /// [return] Vector2型の座標
  void SetPos(Vector2 posi) {
    position = posi;
  }

  /// anchor設定する
  void GetAnchor(Anchor newAnchor) {
    anchor = newAnchor;
  }
}