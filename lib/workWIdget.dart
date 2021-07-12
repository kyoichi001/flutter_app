
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filesave.dart';

enum WorkOption{rename,export, delete,duplicate}

class WorkWidget extends StatelessWidget {

  final SaveFileInfo info;
  final Function(SaveFileInfo) onSelected;
  final Function(WorkOption) onOptionSelected;

  WorkWidget({Key key, this.info, this.onSelected,this.onOptionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            child:FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                onSelected(info);
              },
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  info.loadPreview(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text(info.filename),
                    Text(info.sizeX.toString() + "x" + info.sizeY.toString())
                  ],
                ),
              ),
              PopupMenuButton<WorkOption>
                (
                onSelected: onOptionSelected,
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<WorkOption>>[
                  const PopupMenuItem<WorkOption>(
                    value: WorkOption.duplicate,
                    child: ListTile(
                        leading: Icon(Icons.copy),
                        title: Text("複製")
                    ),
                  ),
                  const PopupMenuItem<WorkOption>(
                    value: WorkOption.rename,
                    child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text("名前変更")
                    ),
                  ),
                  const PopupMenuItem<WorkOption>(
                    value: WorkOption.export,
                    child: ListTile(
                        leading: Icon(Icons.save),
                        title: Text("エクスポート")
                    ),
                  ),
                  const PopupMenuItem<WorkOption>(
                    value: WorkOption.delete,
                    child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text(
                          "削除",
                          style: TextStyle(color:Colors.red),
                        )
                    ),
                  ),
                ],
              )
            ],

          )
        ],
      ),
    );
  }
}

/* decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            offset: new Offset(0.0, 5.0),
            blurRadius: 1.0,
          )
        ],
      ),*/

/*
*  Column(

      children: [
        /**/
        ButtonTheme(
          minWidth: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              onSelected(info);
            },

              child:Image.file(
                info.loadPreview(),
                fit: BoxFit.contain ,
              ),
            ),
          ),
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
*
* */

/*
FlatButton(
      padding: EdgeInsets.all(0),
        onPressed: () {
          onSelected(info);
        },
          child:Container(
            margin: EdgeInsets.all(0),
            width: double.infinity,
            height:double.infinity,
            child: Image.file(
              info.loadPreview(),
              fit:BoxFit.cover,
            ),
            color:Colors.teal,
          ),
    );
    */