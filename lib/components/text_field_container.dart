import 'package:flutter/material.dart';

import '../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: purple.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      );
  }
}
