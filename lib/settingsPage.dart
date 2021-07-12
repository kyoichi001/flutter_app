
import 'package:flutter/material.dart';

import 'filesave.dart';

class AppSettings {
  bool nightMode = false;
  int worksSize = 2;
}

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key, this.settings, this.onSettingsChanged})
      : super(key: key);
  AppSettings settings;
  Function onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () async {
              await FileSave.clearData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'clear all data', textAlign: TextAlign.left,),
                ),
              );
            },
            child: Text("delete all files")
        ),
        SwitchListTile(
          title: const Text('Lights'),
          value: settings.nightMode,
          onChanged: (bool value) {
            settings.nightMode = value;
            onSettingsChanged();
          },
        ),
        Text("作品一覧 サイズ"),
        LabeledRadio(
          label: '大',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: 2,
          groupValue: settings.worksSize,
          onChanged: (int newValue) {
            settings.worksSize = newValue;
            onSettingsChanged();
          },
        ),
        LabeledRadio(
          label: '中',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: 3,
          groupValue: settings.worksSize,
          onChanged: (int newValue) {
            settings.worksSize = newValue;
            onSettingsChanged();
          },
        ),
      ],
    );
  }
}


class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key key,
     this.label,
     this.padding,
     this.groupValue,
     this.value,
     this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<int>(
              groupValue: groupValue,
              value: value,
              onChanged: (int newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}