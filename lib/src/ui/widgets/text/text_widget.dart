// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  const TextWidget(
    this.text, {
    double? pFontSize,
    this.textAlign,
    super.key,
  }) : fontSize = pFontSize ?? 16;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }
}
