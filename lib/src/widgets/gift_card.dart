import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/gift/gift_bloc.dart';
import '../database/gift.dart';
import '../screens/gift_add_screen.dart';
import 'btn.dart';
import 'del_dialog.dart';
import 'image_widget.dart';

class GiftCard extends StatelessWidget {
  const GiftCard({super.key, required this.gift});

  final Gift gift;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.3,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Btn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GiftAddScreen(gift: gift);
                    },
                  ),
                );
              },
              child: SvgPicture.asset('assets/edit.svg'),
            ),
          ),
          SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Btn(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DelDialog(
                      title: 'Delete Gift?',
                      onYes: () {
                        context.read<GiftBloc>().add(GiftDelete(gift: gift));
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
          bottom: 20,
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
            ImageWidget(image: gift.image),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gift.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    gift.details.join(', '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 10,
                      fontFamily: 'w800',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Price: \$${gift.price}',
                    style: TextStyle(
                      color: Color(0xffDD0474),
                      fontSize: 15,
                      fontFamily: 'w800',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
