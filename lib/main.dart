import 'package:flutter/material.dart';
import 'package:make_my_life/pages/gameMainPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:make_my_life/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TitlePage());
  }
}

/// タイトルページのウィジェット（動的）
class TitlePage extends StatefulWidget {
  /// コンストラクタ
  @override
  TitlePage({Key? key}) : super(key: key) {}

  @override
  _titlePageState createState() => _titlePageState();
}

class _titlePageState extends State<TitlePage> {
  //多言語化対応コード
  Locale? _locale;

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  /// 削除処理
  @override
  void dispose() {
    super.dispose();
  }

  Future<Locale> _loadSavedLanguage() async {
    // データ保存用インスタンス生成
    Share share = Share();
    // 設定情報を取得
    await share.getSetting();
    return Locale(share.lang_code ?? 'ja');
  }

  void _changeLanguage(String languageCode) async {
    // データ保存用インスタンス生成
    Share share = Share();
    await share.setLangCode(languageCode); // 言語設定を保存します
    Locale locale = await _loadSavedLanguage();
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO:temp
    _locale = Locale('ja');
    // TODO:temp
    if (_locale == null) {
      // Localeがまだ読み込まれていない場合は、ローディングスピナーを表示します
      return CircularProgressIndicator();
    } else {
      return MaterialApp(
        locale: _locale,
        localizationsDelegates: [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ja'),
        ],
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          onLanguageChanged: _changeLanguage,
        ),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ValueChanged<String> onLanguageChanged;

  MyHomePage({Key? key, required this.title, required this.onLanguageChanged})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// ウィジェット生成
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ヘッダーバーを消す
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      // コンテンツ内容
      body: Container(
        width: double.infinity, // 横幅を端末サイズに合わせる
        color: Colors.white,
        // 縦にウィジェットを配置する
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // タイトル
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 300,
                bottom: 10,
              ),
              //// 内側の余白
              //padding: EdgeInsets.only(
              //  top: 300,
              //  bottom: 10,
              //),
              child: Column(
                children: [
                  // タイトルテキスト
                  Text(
                    "人生シミュレーション",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64,
                    ),
                  ),
                  // サブタイトルテキスト
                  Text(
                    "~ MAKE MY LIFE ~",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            // スタートボタン
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 0,
                bottom: 0,
              ),
              width: 300,
              height: 50,
              child: OutlinedButton(
                child: Text(
                  "スタート",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                onPressed: () async {
                  // メモページに移動する
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameMainPage()));
                },
              ),
            ),
            // 著作権表示
            Container(
              // 外側の余白
              margin: EdgeInsets.only(
                top: 0,
                bottom: 25,
              ),
              child: Text(
                "Copyright © 2023- MGSystems All Rights Reserved.\nhttps://mgsystems.onrender.com",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
