import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/btn.dart';
import '../widgets/button.dart';
import '../widgets/rotated.dart';
import '../widgets/scaffold2.dart';
import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Stack(
        children: [
          SvgPicture.asset(
            first ? 'assets/start_bg.svg' : 'assets/start_bg2.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          if (first) ...[
            Positioned(
              top: 0,
              left: 110,
              child: SvgPicture.asset('assets/balloon2.svg'),
            ),
            Positioned(
              top: 226,
              left: 0,
              right: 0,
              child: SvgPicture.asset('assets/balloon.svg'),
            ),
            Positioned(
              top: 50,
              right: 0,
              child: SvgPicture.asset('assets/balloon3.svg'),
            ),
            Positioned(
              top: 130,
              left: 14,
              child: SvgPicture.asset('assets/balloon4.svg'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset('assets/balloon4.svg'),
            ),
          ] else ...[
            Positioned(
              top: 54,
              left: 0,
              child: Rotated(
                degree: -9,
                child: Image.asset('assets/gift.png', height: 120),
              ),
            ),
            Positioned(
              top: 45,
              right: 15,
              child: Rotated(
                degree: 30,
                child: Image.asset('assets/gift.png', height: 93),
              ),
            ),
            Positioned(
              top: 366,
              right: -46,
              child: Rotated(
                degree: 12,
                child: Image.asset('assets/gift.png', height: 122),
              ),
            ),
            Positioned(
              top: 228,
              left: 0,
              right: 0,
              child: Rotated(
                degree: -40,
                child: Image.asset('assets/gift.png', height: 155),
              ),
            ),
            Positioned(
              top: 442,
              left: -18,
              child: Rotated(
                degree: -26,
                child: Image.asset('assets/gift.png', height: 77),
              ),
            ),
            Positioned(
              bottom: 163,
              right: 40,
              child: Rotated(
                degree: 9,
                child: Image.asset('assets/gift.png', height: 52),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -30,
              child: Rotated(
                degree: -30,
                child: Image.asset('assets/gift.png', height: 145),
              ),
            ),
          ],
          Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  first
                      ? 'The app helps you to organise your birthday party in a quality way'
                      : 'Keep the gift and guest list updated so you don\'t miss anything.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'w800',
                  ),
                ),
              ),
              SizedBox(height: 70),
              Button(
                title: first ? 'Next' : 'Start',
                onPressed: () async {
                  if (first) {
                    setState(() {
                      first = false;
                    });
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('start', false);
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    }
                  }
                },
              ),
              // terms button
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(height: 14),
                    // if (first)
                    Btn(
                      onPressed: () {},
                      minSize: 18,
                      child: Text(
                        'Terms of Use / Privacy Policy',
                        style: TextStyle(
                          color: Color(0xffFAFAFA),
                          fontSize: 14,
                          fontFamily: 'w900',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
