
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filesave.dart';

enum WorkOption{export, delete}

class WorkWidget extends StatelessWidget {

  SaveFileInfo info;
  Function(SaveFileInfo) onSelected;

  WorkWidget({Key key, this.info,this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Image.file(
            info.loadPreview(),
          ),
          onPressed: (){onSelected(info);},
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(info.filename),
                  Text(info.sizeX.toString() + "x" + info.sizeY.toString())
                ],
              ),
            ),
            PopupMenuButton<WorkOption>
              (
              onSelected: onSelect,
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<WorkOption>>[
                const PopupMenuItem<WorkOption>(
                  value: WorkOption.export,
                  child: ListTile(
                      leading: Icon(Icons.save),
                      title: Text("export")
                  ),
                ),
                const PopupMenuItem<WorkOption>(
                  value: WorkOption.delete,
                  child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("delete")
                  ),
                ),
              ],
            )
          ],

        )
      ],
    );
  }

  void onSelect(WorkOption option) {

  }
}