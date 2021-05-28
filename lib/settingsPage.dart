
import 'package:flutter/material.dart';

import 'filesave.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool nightmode=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body:Column(
          children: [
            TextButton(
                onPressed:clearData ,
                child: Text("delete all files")
            ),
            SwitchListTile(
              title: const Text('Lights'),
              value: nightmode,
              onChanged: (bool value) {
                setState(() {
                  nightmode = value;
                });
              },
            )
          ],
        )
    );
  }

  void clearData() {
    FileSave.clearData().then(
            (void e) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('clear all data'),
              ),
            );
          });
        }
    );
  }

}
