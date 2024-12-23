import 'package:flutter/material.dart';

import 'btn.dart';

class DelDialog extends StatelessWidget {
  const DelDialog({
    super.key,
    required this.title,
    required this.onYes,
  });

  final String title;
  final void Function() onYes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff3CC8FF),
      child: SizedBox(
        height: 160,
        width: 200,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'w900',
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const SizedBox(width: 20),
                Btn(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'w900',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Btn(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'w900',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onYes();
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
