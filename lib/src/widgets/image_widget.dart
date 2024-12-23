import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.image,
    this.height = 70,
    this.asset = '',
  });

  final String image;
  final double height;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: Image.file(
          File(image),
          height: height,
          width: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print(error);
            return asset.isEmpty
                ? Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffD9D9D9),
                    ),
                  )
                : Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/$asset.svg'),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
