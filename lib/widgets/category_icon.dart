import 'package:flutter/material.dart';
import '../pages/category_products_page.dart';
import '../styles/styles.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.name,
    required this.iconUrl,
    required this.id,
  });

  final int id;
  final String name;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryProductPage(id: id)));
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
