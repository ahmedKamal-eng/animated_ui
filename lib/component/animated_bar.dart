
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  bool isActive;
  AnimatedBar({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      width: isActive?20:0,
      height: 4,
      decoration: BoxDecoration(
        color: Color(0xff81b4ff),
        borderRadius: BorderRadius.all(Radius.circular(12),),
      ),
    );
  }
}
