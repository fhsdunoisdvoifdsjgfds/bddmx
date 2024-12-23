import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/friend/friend_bloc.dart';
import '../database/friend.dart';
import '../screens/friend_add_screen.dart';
import '../utils.dart';
import 'btn.dart';
import 'del_dialog.dart';
import 'image_widget.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    super.key,
    required this.friend,
  });

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.3,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Btn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FriendAddScreen(friend: friend);
                    },
                  ),
                );
              },
              child: SvgPicture.asset('assets/edit.svg'),
            ),
          ),
          SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Btn(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DelDialog(
                      title: 'Delete Friend?',
                      onYes: () {
                        context
                            .read<FriendBloc>()
                            .add(FriendDelete(friend: friend));
                      },
                    );
                  },
                );
              },
              child: SvgPicture.asset('assets/delete.svg'),
            ),
          ),
        ],
      ),
      child: Container(
        height: 82,
        margin: EdgeInsets.only(
          bottom: 30,
          left: 20,
          right: 20,
        ),
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
        child: Row(
          children: [
            SizedBox(width: 8),
            ImageWidget(image: friend.image),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${friend.name} ${friend.surname}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    friend.birth,
                    style: TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 10,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formatTimestamp(friend.id),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'w800',
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Turns:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'w800',
                  ),
                ),
                Text(
                  calculateAge(friend.birth),
                  style: TextStyle(
                    color: Color(0xffDD0474),
                    fontSize: 42,
                    fontFamily: 'w800',
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
