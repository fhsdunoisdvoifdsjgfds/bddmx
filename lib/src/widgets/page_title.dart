import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'btn.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.subtitle = '',
    this.back = false,
    this.onDelete,
  });

  final String title;
  final String subtitle;
  final bool back;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20 + MediaQuery.of(context).viewPadding.top,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              if (back)
                Btn(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  minSize: 44,
                  child: SvgPicture.asset('assets/back.svg'),
                ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'w800',
                    ),
                  ),
                ),
              ),
              if (back)
                onDelete == null
                    ? SizedBox(width: 44)
                    : Btn(
                        onPressed: onDelete,
                        minSize: 44,
                        child: SvgPicture.asset(
                          'assets/delete.svg',
                          height: 20,
                        ),
                      ),
              SizedBox(width: 20),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'w800',
            ),
          ),
        ],
      ),
    );
  }
}
