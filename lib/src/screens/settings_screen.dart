import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/btn.dart';
import '../widgets/button.dart';
import '../widgets/page_title.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle(title: 'Settings'),
        SizedBox(height: 50),
        Button(
          title: 'Profile',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen();
                },
              ),
            );
          },
        ),
        SizedBox(height: 22),
        Button(
          title: 'My friends',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return FriendsScreen();
                },
              ),
            );
          },
        ),
        SizedBox(height: 40),
        _Button(id: 1, title: 'Privacy Policy'),
        _Divider(),
        _Button(id: 2, title: 'Terms of use'),
        _Divider(),
        _Button(id: 3, title: 'Share with friends'),
        _Divider(),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Btn(
      onPressed: () {
        if (id == 1) {}
        if (id == 2) {}
        if (id == 3) {}
      },
      minSize: 48,
      child: Row(
        children: [
          SizedBox(width: 30),
          SvgPicture.asset('assets/settings$id.svg'),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'w800',
            ),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right,
            color: Color(0xffDD0474),
            size: 28,
          ),
          SizedBox(width: 26),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(horizontal: 30),
      color: Colors.white.withValues(alpha: 0.3),
    );
  }
}
