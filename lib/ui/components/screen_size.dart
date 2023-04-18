import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';

class ScreenSize extends StatelessWidget {
  final Widget child;
  const ScreenSize({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: child,
    );
  }
}
