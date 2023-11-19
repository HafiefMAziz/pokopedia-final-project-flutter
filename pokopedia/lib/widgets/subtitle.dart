import 'package:flutter/material.dart';
import '../styles/styles.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key, required this.text, required this.fontSize,
  });
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(text, 
      style: TextStyle(color: navy(), fontWeight: FontWeight.bold, fontSize: fontSize),),
    );
  }
}