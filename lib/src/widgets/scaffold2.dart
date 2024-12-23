import 'package:flutter/material.dart';

class Scaffold2 extends StatelessWidget {
  const Scaffold2({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff00BEFF),
                  Color(0xff009DFE),
                ],
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
