import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/bottom/bottom_bloc.dart';
import 'btn.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 34),
        child: BlocBuilder<BottomBloc, BottomState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Bottom(id: 1, title: 'Home', active: state is BottomInitial),
                _Bottom(id: 2, title: '2', active: state is BottomGuests),
                _Bottom(id: 3, title: '3', active: state is BottomGifts),
                _Bottom(id: 4, title: '4', active: state is BottomSettings),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({
    required this.id,
    required this.title,
    required this.active,
  });

  final int id;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Btn(
      onPressed: active
          ? null
          : () {
              context.read<BottomBloc>().add(ChangeBottom(page: id));
            },
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(active ? 2 : 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: active
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff60D7FD),
                    Color(0xff028BDA),
                  ],
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                active ? Color(0xffF98FE0) : Color(0xff60D7FD),
                active ? Color(0xffDD0474) : Color(0xff028BDA),
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset('assets/bottom$id.svg'),
          ),
        ),
      ),
    );
  }
}
