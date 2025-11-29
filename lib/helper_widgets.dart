import 'package:flutter/material.dart';

class IfWidget extends StatelessWidget {
  final Widget isTrue;
  final Widget? isFalse;
  final bool condition;

  const IfWidget({super.key, required this.isTrue, this.isFalse, required this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? isTrue : (isFalse ?? const SizedBox.shrink());
  }
}