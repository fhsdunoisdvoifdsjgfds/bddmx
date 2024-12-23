import 'package:flutter/material.dart';

import 'btn.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Btn(
      onPressed: onPressed,
      minSize: 24,
      child: Container(
        height: 24,
        width: 118,
        decoration: BoxDecoration(
          color: Color(0xffDD0474),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            'Add photo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'w800',
            ),
          ),
        ),
      ),
    );
  }
}
