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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppTheme.materialBlue,
      ),
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
int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Editor'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async{
              await Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (context) => SettingsPage(),
                  )
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Center(
        child: HomePage(),
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
        selectedItemColor: AppTheme.materialBlue[800],
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
