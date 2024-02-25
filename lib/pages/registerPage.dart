import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:make_my_life/share.dart';
import '../common/myButton.dart';
import '../common/myWord.dart';

/// ゲームメイン
class RegisterPage extends StatefulWidget {
  RegisterPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

Size viewSize = new Size(0, 0);

class _RegisterPageState extends State<RegisterPage> {
  String? selectedMonth; // 初期値
  String? selectedDate; // 初期値
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("ユーザー情報画面"),
              leadingWidth: 85, //leadingWidthを設定する
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
            body: Center(
                child: Container(
              width: 1000,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Enter your username',
                          labelText: "username",
                        )),
                    SizedBox(height: 16), // 余白を追加
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 要素の配置を調整
                      children: [
                        Text('誕生日:'),
                        // Text('名前:$_textEditingController.text'),

                        DropdownButton<String>(
                          value: selectedMonth,
                          hint: Text('月'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                            });
                          },
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16), // 余白を追加

                        DropdownButton<String>(
                          value: selectedDate,
                          hint: Text('日'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDate = newValue!;
                            });
                          },
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16), // 余白を追加
                      ],
                    ),

                    SizedBox(height: 24), // 余白を追加
                    DropdownButton<String>(
                      value: selectedDate,
                      hint: Text('日'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDate = newValue!;
                        });
                      },
                      items: <String>[
                        '日本語',
                        '英語',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16), // 余白を追加

                    TextButton(
                      onPressed: () {
                        // ボタンが押された時の処理を追加
                        print('TextButtonが押されました！');
                        updateSettings(_textEditingController.text,
                            selectedMonth, selectedDate);
                      },
                      child: Text('update'),
                    ),
                  ]),
            ))));
  }

  // ***********************************************
  // *
  // *	メソッド
  // *
  // ***********************************************
  /**
  * 入力内容登録処理
  * @param String name
  * @param String? month
  * @param String? date
  * @return void
  */
  void updateSettings(String name, String? month, String? date) async {
    // データ保存用インスタンス生成
    Share share = Share();
    // ユーザ名を設定
    await share.setName(name);
    // ユーザ誕生日を設定
    await share.setBirthDay('$month / $date');

    // 設定情報を取得
    await share.getSetting();
    print(share.user_name);
    print(share.birth_day);
  }
}


  // ***********************************************
  // *
  // *	メソッド
  // *
  // ***********************************************
  // void onPressed(String type) async {
  //   print("ボタンクリック内容");
  //   print(type);

  //   switch (type) {
  //     case "\n金利を上げる":
  //       print("金利上昇");
  //       // データ保存用インスタンス生成
  //       Share share = Share();
  //       // 金利を上昇させる
  //       await share.setRate(-0.25);
  //       // 月カウンターをインクリメント
  //       await share.setCounter();
  //       // 設定情報を取得
  //       await share.getSetting();
  //       print(share.date_counter);
  //       print(share.rate);
  //       break;

  //     case "\n金利を下げる":
  //       print("金利下降");
  //       // データ保存用インスタンス生成
  //       Share share = Share();
  //       // 金利を下降させる
  //       await share.setRate(-0.25);
  //       // 月カウンターをインクリメント
  //       await share.setCounter();
  //       // 設定情報を取得
  //       await share.getSetting();
  //       print(share.date_counter);
  //       print(share.rate);
  //       break;
  //     default:
  //   }
