import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final double? height, width, borderRadius;
  final Color color;
  final Widget child;
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 100,
    required this.child,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: screenHeight(context, height ?? 55),
          width: width ?? screenWidth(context, 100),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: Center(child: child)),
    );
  }
}
