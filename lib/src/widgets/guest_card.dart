import 'package:flutter/material.dart';

import '../database/guest.dart';
import '../screens/guest_add_screen.dart';
import 'btn.dart';
import 'image_widget.dart';

class GuestCard extends StatelessWidget {
  const GuestCard({
    super.key,
    required this.guest,
  });

  final Guest guest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff00BEFF),
            Color(0xff009DFE),
          ],
        ),
      ),
      child: Btn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GuestAddScreen(guest: guest);
              },
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(width: 8),
            ImageWidget(image: guest.image),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${guest.name} ${guest.surname}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    guest.status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 12,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${guest.age} years',
                    style: TextStyle(
                      color: Color(0xffDD0474),
                      fontSize: 8,
                      fontFamily: 'w800',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
