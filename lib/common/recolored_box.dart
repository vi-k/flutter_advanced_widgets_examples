import 'dart:math';

import 'package:flutter/material.dart';

class RecoloredBox extends StatelessWidget {
  static final _random = Random();

  final Widget child;

  const RecoloredBox({
    super.key,
    required this.child,
  });

  Color get _randomColor => Color.fromARGB(
        255,
        128 + _random.nextInt(128),
        128 + _random.nextInt(128),
        128 + _random.nextInt(128),
      );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _randomColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
