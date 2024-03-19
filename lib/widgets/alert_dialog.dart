import 'package:flutter/material.dart';

import '../styles/styles.dart';
import 'subtitle.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    required this.titleMessage,
    required this.contentMessage,
  });

  final String titleMessage;
  final String contentMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightBlue(),
      title: Subtitle(text: titleMessage, fontSize: 25),
      content: Text(
        contentMessage,
        style: TextStyle(
            color: navy(),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK',
              style: TextStyle(
                  color: navy(),
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}