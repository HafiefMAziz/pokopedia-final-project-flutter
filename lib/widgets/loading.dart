import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../styles/styles.dart';

class PokoLoading extends StatelessWidget {
  const PokoLoading({
    super.key, required this.size,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(15),
          child: LoadingAnimationWidget.twoRotatingArc(
            color: navy(),
            size: size,
          ),
        ),
    );
  }
}
