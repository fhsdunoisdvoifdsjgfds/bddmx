import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/scaffold2.dart';
import 'home_screen.dart';
import 'start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController turns;

  void getStart() async {
    final prefs = await SharedPreferences.getInstance();
    bool start = prefs.getBool('start') ?? true;
    Future.delayed(
      Duration(seconds: 2),
      () {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => start ? StartScreen() : HomeScreen(),
            ),
            (route) => false,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    turns = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    getStart();
  }

  @override
  void dispose() {
    turns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Center(
        // child: CupertinoActivityIndicator(
        //   radius: 16,
        // ),
        child: RotationTransition(
          turns: turns,
          child: SvgPicture.asset(
            'assets/balloon.svg',
            height: 100,
          ),
        ),
      ),
    );
  }
}
