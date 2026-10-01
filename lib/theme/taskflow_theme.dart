import 'package:flutter/material.dart';

const ink = Color(0xff0b1c30);
const muted = Color(0xff464555);
const canvas = Color(0xfff8f9ff);
const pale = Color(0xffeff4ff);
const blue = Color(0xffdce9ff);
const primary = Color(0xff4f46e5);
const green = Color(0xff006e4b);
const mint = Color(0xff67f4b7);
const red = Color(0xffba1a1a);

ThemeData buildTaskFlowTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: canvas,
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
  fontFamily: 'Arial',
);
