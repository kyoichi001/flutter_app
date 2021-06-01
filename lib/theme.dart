import 'package:flutter/material.dart';

class AppTheme{

  //https://zenn.dev/sugitlab/articles/bef3a05963680a
  static const MaterialColor appPrimary = MaterialColor(
    0xff756ea1,
    <int, Color>{
      50: Color(0xffcae3f6),
      100: Color(0xffacd1f1),
      200: Color(0xff7eb1e2),
      300: Color(0xff639ed7),
      400: Color(0xff488fcd),
      500: Color(0xff3277b8),
      600: Color(0xff24619c),
      700: Color(0xff11518c),//pivot
      800: Color(0xff063f72),
      900: Color(0xff022c53),
    },
  );
  static const MaterialColor appSecondary = MaterialColor(
    0xff756ea1,
    <int, Color>{
      50: Color(0xfff6d4d3),
      100: Color(0xffe8aeaa),
      200: Color(0xffd2807b),
      300: Color(0xffce625c),
      400: Color(0xffc44d47),
      500: Color(0xffc23f38),
      600: Color(0xffbd352e),
      700: Color(0xffab241d),//pivot
      800: Color(0xff7f110c),
      900: Color(0xff7b0a04),
    },
  );
}