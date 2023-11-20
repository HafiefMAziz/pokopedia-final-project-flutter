import 'package:flutter/material.dart';
import '../styles/styles.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.name,
    required this.iconUrl,
  });

  final String name;
  final String iconUrl;

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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                  color: navy(),
                  iconUrl,
                  fit: BoxFit.cover,
                  ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Text(
            name,
            style: TextStyle(color: navy(), fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
