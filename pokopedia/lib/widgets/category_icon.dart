import 'package:flutter/material.dart';
import '../styles/styles.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print("Navigate to Category");
          },
          child: Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            decoration: BoxDecoration(
              color: lightBlue(),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chair),
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Text(
              name,
              style: TextStyle(color: navy(), fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
