import 'package:flutter/material.dart';
import 'package:pokopedia/styles/styles.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key, this.onTap, this.icon, required this.selected,
  });
  final void Function()? onTap;
  final IconData? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Icon(icon, size: selected ? 35 : 25, color: selected ? red() : blueGreen()),
      ),
    );
  }
}
