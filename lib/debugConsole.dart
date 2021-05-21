import 'package:flutter/cupertino.dart';

class DebugConsoleWidget extends StatefulWidget {
  static List<String> debugText = [];
  static void addText(String text) {
    debugText.add(text);
  }

  DebugConsoleWidget({Key key}) : super(key: key);

  @override
  _DebugConsoleWidgetState createState() => _DebugConsoleWidgetState();
}


class _DebugConsoleWidgetState extends State<DebugConsoleWidget> {

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.bottomLeft,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Text(
                  DebugConsoleWidget.debugText[index]
              );
            },
            itemCount: DebugConsoleWidget.debugText.length,
          )
      ),
    );
  }
}