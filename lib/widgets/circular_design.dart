import 'package:flutter/material.dart';

class CircularDesign extends StatelessWidget {
  final double radius;
  final Color color;
  final double opacity;
  final double x;
  final double y;
  final double z;
  const CircularDesign({
    super.key, 
    required this.radius,
    this.color = Colors.white,
    this.opacity = 0.3,
    this.x = 0,
    this.y =0,
    this.z = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      transform: Matrix4.translationValues(x, y, z),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color.withOpacity(opacity)
      ),
    );
  }
}