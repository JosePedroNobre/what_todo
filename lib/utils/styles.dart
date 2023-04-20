import 'package:flutter/material.dart';

TextStyle telegraf({color = Colors.white, required double size, FontWeight? fontWeight}) {
  return TextStyle(
    fontFamily: 'Telegraf',
    fontSize: size,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
    decoration: TextDecoration.none,
  );
}
