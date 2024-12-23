import 'dart:async';
import 'package:flutter/material.dart';

class BirthTimer extends StatefulWidget {
  const BirthTimer({super.key, required this.birth});

  final DateTime birth;

  @override
  State<BirthTimer> createState() => _BirthTimerState();
}

class _BirthTimerState extends State<BirthTimer> {
  late DateTime nextBirthday;
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    nextBirthday = calculateNextBirthday(widget.birth);
    remainingTime = nextBirthday.difference(DateTime.now());
    startTimer();
  }

  DateTime calculateNextBirthday(DateTime date) {
    DateTime now = DateTime.now();
    DateTime next = DateTime(now.year, date.month, date.day);
    if (next.isBefore(now)) {
      next = DateTime(now.year + 1, date.month, date.day);
    }
    return next;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = nextBirthday.difference(DateTime.now());
      });
      if (remainingTime.isNegative) {
        timer.cancel();
      }
    });
  }

  List<int> getDigits(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    List<int> dayDigits = days < 100
        ? days.toString().padLeft(2, '0').split('').map(int.parse).toList()
        : days.toString().padLeft(3, '0').split('').map(int.parse).toList();

    return [
      ...dayDigits,
      -1,
      hours ~/ 10,
      hours % 10,
      -1,
      minutes ~/ 10,
      minutes % 10,
      -1,
      seconds ~/ 10,
      seconds % 10,
    ];
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> digits = getDigits(remainingTime);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            Text(
              'Days',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'w800',
              ),
            ),
            SizedBox(width: 50),
            Text(
              'Hours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'w800',
              ),
            ),
            SizedBox(width: 40),
            Text(
              'Minutes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'w800',
              ),
            ),
            SizedBox(width: 30),
            Text(
              'Seconds',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'w800',
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: digits.map((number) {
            double spacing;
            if (number == -1) {
              if (digits.indexOf(number) < 3) {
                spacing = 2;
              } else if (digits.indexOf(number) < 6) {
                spacing = 12;
              } else {
                spacing = 12;
              }
              return SizedBox(width: spacing);
            } else {
              return Padding(
                padding: EdgeInsets.only(right: 4),
                child: Container(
                  width: 32,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        color: Color(0xff424242),
                        fontSize: 34,
                        fontFamily: 'w800',
                      ),
                    ),
                  ),
                ),
              );
            }
          }).toList(),
        ),
      ],
    );
  }
}
