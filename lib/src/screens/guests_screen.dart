import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/guest/guest_bloc.dart';
import '../widgets/btn.dart';
import '../widgets/guest_card.dart';
import '../widgets/page_title.dart';
import 'guest_add_screen.dart';

class GuestsScreen extends StatelessWidget {
  const GuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            BlocBuilder<GuestBloc, GuestState>(
              builder: (context, state) {
                return PageTitle(
                  title: 'Guests',
                  subtitle:
                      '${state is GuestLoaded ? state.guests.length : 0} guests',
                );
              },
            ),
            SizedBox(height: 10),
            BlocBuilder<GuestBloc, GuestState>(
              builder: (context, state) => state is GuestLoaded
                  ? Flexible(
                      child: GridView.builder(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 200,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.8,
                        ),
                        itemCount: state.guests.length,
                        itemBuilder: (context, index) {
                          return GuestCard(guest: state.guests[index]);
                        },
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
        Positioned(
          right: 33,
          bottom: 105,
          child: Btn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GuestAddScreen();
                  },
                ),
              );
            },
            child: SvgPicture.asset('assets/add.svg'),
          ),
        ),
      ],
    );
  }
}
