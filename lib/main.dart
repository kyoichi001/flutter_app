import 'package:flutter/material.dart';
import 'package:flutter_app/settingsPage.dart';
import 'package:flutter_app/theme.dart';
import 'homepage.dart';

void main() {
//https://qiita.com/tatsu/items/68cf1125bfb167e2f6e8
  //debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'cat pixel',
        theme: ThemeData(
          primaryColor: Color(0xff11518c),
          accentColor:Color(0xff80DFDA),
          primarySwatch: AppTheme.appPrimary,
        ),
        darkTheme: ThemeData.dark(),
        home: MainWiget()
    );
  }
}

class MainWiget extends StatefulWidget {
  const MainWiget({Key key}) : super(key: key);
  @override
  MainWigetState createState() => MainWigetState();
}

class MainWigetState extends State<MainWiget> {
  AppSettings settings=AppSettings();
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      SettingsPage(settings: settings,)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('cat pixel'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.appSecondary[700],
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
