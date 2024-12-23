import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/bottom/bottom_bloc.dart';
import '../controllers/friend/friend_bloc.dart';
import '../controllers/gift/gift_bloc.dart';
import '../controllers/profile/profile_bloc.dart';
import '../utils.dart';
import '../widgets/birth_timer.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/btn.dart';
import '../widgets/image_widget.dart';
import '../widgets/scaffold2.dart';
import 'friend_add_screen.dart';
import 'friends_screen.dart';
import 'gift_add_screen.dart';
import 'gifts_screen.dart';
import 'guests_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: BlocProvider(
        create: (context) => BottomBloc(),
        child: Stack(
          children: [
            BlocConsumer<BottomBloc, BottomState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is BottomGuests) return GuestsScreen();

                if (state is BottomGifts) return GiftsScreen();

                if (state is BottomSettings) return SettingsScreen();

                return Column(
                  children: [
                    SizedBox(
                      height: 20 + MediaQuery.of(context).viewPadding.top,
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoaded) {
                          return Row(
                            children: [
                              SizedBox(width: 20),
                              ImageWidget(
                                image: state.image,
                                height: 44,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Hello, ${state.name.isEmpty ? 'User' : state.name}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'w800',
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Your birthday starts in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'w800',
                      ),
                    ),
                    SizedBox(height: 16),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) => state is ProfileLoaded
                          ? BirthTimer(birth: stringToDate(state.birth))
                          : Container(),
                    ),
                    SizedBox(height: 40),
                    _Section(
                      title: 'Friends\' birthdays',
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
                    SizedBox(height: 16),
                    BlocBuilder<FriendBloc, FriendState>(
                        builder: (context, state) {
                      if (state is FriendLoaded) {
                        return SizedBox(
                          height: 82,
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 22, right: 6),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                sortIncomingBirthdays(state.friends).length,
                            itemBuilder: (context, index) {
                              return Btn(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FriendAddScreen(
                                          friend: state.friends[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 52,
                                  margin: EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: [
                                      ImageWidget(
                                        image: state.friends[index].image,
                                        height: 52,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        state.friends[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'w800',
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        convertDate(state.friends[index].birth),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'w800',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return Container();
                    }),
                    SizedBox(height: 20),
                    _Section(
                      title: 'My last birthday presents',
                      onPressed: () {
                        context.read<BottomBloc>().add(ChangeBottom(page: 3));
                      },
                    ),
                    SizedBox(height: 16),
                    BlocBuilder<GiftBloc, GiftState>(
                      builder: (context, state) => state is GiftLoaded
                          ? SizedBox(
                              height: 82,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 22, right: 6),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.gifts.length,
                                itemBuilder: (context, index) {
                                  return Btn(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return GiftAddScreen(
                                              gift: state.gifts[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 52,
                                      margin: EdgeInsets.only(right: 16),
                                      child: Column(
                                        children: [
                                          ImageWidget(
                                            image: state.gifts[index].image,
                                            height: 52,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            state.gifts[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'w800',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(height: 20),
                    // _Section(
                    //   title: 'My wish list',
                    //   onPressed: () {},
                    // ),
                    // SizedBox(height: 16),
                    // BlocBuilder<FriendBloc, FriendState>(
                    //   builder: (context, state) => state is FriendLoaded
                    //       ? SizedBox(
                    //           height: 82,
                    //           child: ListView.builder(
                    //             itemCount: state.friends.length,
                    //             itemBuilder: (context, index) {
                    //               return Container();
                    //             },
                    //           ),
                    //         )
                    //       : Container(),
                    // ),
                  ],
                );
              },
            ),
            const BottomWidget(),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 24),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'w800',
            ),
          ),
        ),
        Btn(
          onPressed: onPressed,
          minSize: 20,
          child: Text(
            'See All',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'w800',
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
