import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/friend/friend_bloc.dart';
import '../widgets/btn.dart';
import '../widgets/friend_card.dart';
import '../widgets/page_title.dart';
import '../widgets/scaffold2.dart';
import 'friend_add_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Stack(
        children: [
          Column(
            children: [
              PageTitle(
                title: 'My friends',
                back: true,
              ),
              BlocBuilder<FriendBloc, FriendState>(
                builder: (context, state) => state is FriendLoaded
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: state.friends.length,
                          itemBuilder: (context, index) {
                            return FriendCard(friend: state.friends[index]);
                          },
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
          Positioned(
            right: 33,
            bottom: 60,
            child: Btn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FriendAddScreen();
                    },
                  ),
                );
              },
              child: SvgPicture.asset('assets/add.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
