import 'package:flutter/material.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key, this.onTap, this.icon, this.iconColor,
  });
  final void Function()? onTap;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
