import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/gift/gift_bloc.dart';
import '../widgets/btn.dart';
import '../widgets/gift_card.dart';
import '../widgets/page_title.dart';
import 'gift_add_screen.dart';

class GiftsScreen extends StatelessWidget {
  const GiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            BlocBuilder<GiftBloc, GiftState>(
              builder: (context, state) {
                return PageTitle(
                  title: 'Gifts',
                  subtitle:
                      '${state is GiftLoaded ? state.gifts.length : 0} gifts',
                );
              },
            ),
            SizedBox(height: 10),
            BlocBuilder<GiftBloc, GiftState>(
              builder: (context, state) => state is GiftLoaded
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20, bottom: 200),
                        itemCount: state.gifts.length,
                        itemBuilder: (context, index) {
                          return GiftCard(gift: state.gifts[index]);
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
                    return GiftAddScreen();
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
