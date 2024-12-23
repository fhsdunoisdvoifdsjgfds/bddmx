import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 248,
        decoration: BoxDecoration(
          color: active ? Color(0xffDD0474) : Color(0xff9E9E9E),
          borderRadius: BorderRadius.circular(40),
        ),
        child: CupertinoButton(
          onPressed: active ? onPressed : null,
          padding: EdgeInsets.zero,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'w800',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
