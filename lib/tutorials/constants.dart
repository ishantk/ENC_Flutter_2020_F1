import 'package:flutter/material.dart';

// for colors: https://material.io/design/color/the-color-system.html#color-usage-and-palettes

const Color kCyan50 = Color(0xE0F7FA);
const Color kCyan100 = Color(0xB2EBF2);
const Color kCyan300 = Color(0x4DD0E1);
const Color kCyan400 = Color(0x26C6DA);

const Color kBlueGray600 = Color(0x546E7A);
const Color kBlueGray900 = Color(0x263238);

const Color kError = Color(0xF44336);

const Color kSurface = Color(0xFAFAFA);
const Color kBackgroundWhite = Colors.white;

const kLetterSpacing = 0.03;

const ColorScheme kColorScheme = ColorScheme(
  primary: kCyan100,
  primaryVariant:kBlueGray900,
  secondary: kCyan50,
  secondaryVariant: kBlueGray900,
  surface: kSurface,
  background: kBackgroundWhite,
  error: kError,
  onPrimary: kBlueGray900,
  onSecondary: kBlueGray900,
  onSurface: kBlueGray900,
  onBackground: kBlueGray900,
  onError: kBackgroundWhite,
  brightness: Brightness.light
);


