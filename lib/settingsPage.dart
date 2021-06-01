
import 'package:flutter/material.dart';

import 'filesave.dart';

class AppSettings{
  bool nightMode=false;
}

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key,this.settings}) : super(key: key);
  AppSettings settings;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed:()async {
              await FileSave.clearData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('clear all data',textAlign: TextAlign.left,),
                ),
              );
            } ,
            child: Text("delete all files")
        ),
        SwitchListTile(
              title: const Text('Lights'),
              value: settings.nightMode,
              onChanged: (bool value) {
                settings.nightMode=value;
              },
            )
      ],
    );
  }

}