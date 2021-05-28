import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/settingsPage.dart';
import 'debugConsole.dart';
import 'homepage.dart';

void main() {
//https://qiita.com/tatsu/items/68cf1125bfb167e2f6e8
  //debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  //https://zenn.dev/sugitlab/articles/bef3a05963680a
  static const MaterialColor white = MaterialColor(
    0xFFC8CCD2,
    <int, Color>{
      50: Color(0xFFFCFCFF),
      100: Color(0xFFF2F6FA),
      200: Color(0xFFEFF2F6),
      300: Color(0xFFDFE6EA),
      400: Color(0xFFCACFD4),
      500: Color(0xFFA3A7AD),
      600: Color(0xFF85878E),
      700: Color(0xFF75767D),
      800: Color(0xFF5C5C61),
      900: Color(0xFF444447),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MyApp.white,
      ),
      home: MainWiget()
    );
  }
}

class MainWiget extends StatelessWidget {
  const MainWiget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Editor'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsPage(
                        ),
                  )
              );
            },
          ),
        ],
      ),
      body:
      Center(
        child: HomePage(),
      ),
    );
  }
}
