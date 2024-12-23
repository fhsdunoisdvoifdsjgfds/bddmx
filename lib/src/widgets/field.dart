import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class Field extends StatefulWidget {
  const Field({
    super.key,
    required this.controller,
    required this.hintText,
    this.onlyNumber = false,
    this.multiline = false,
    this.maxLength = 20,
    this.datePicker = false,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool onlyNumber;
  final bool multiline;
  final int maxLength;
  final bool datePicker;
  final void Function() onChanged;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  void onDateTimeChanged(DateTime date) {
    setState(() {
      widget.controller.text = dateToString(date);
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: widget.controller,
        readOnly: widget.datePicker ? true : false,
        keyboardType: widget.onlyNumber
            ? TextInputType.number
            : widget.multiline
                ? TextInputType.multiline
                : null,
        maxLines: widget.multiline ? null : 1,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
          if (widget.onlyNumber) FilteringTextInputFormatter.digitsOnly
        ],
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'w500',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.multiline ? 10 : 0,
            horizontal: 22,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'w500',
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          widget.onChanged();
        },
        onTap: () async {
          if (widget.datePicker) {
            await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: Color(0xff3CC8FF),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'w600',
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      onDateTimeChanged: onDateTimeChanged,
                      initialDateTime: stringToDate(widget.controller.text),
                      mode: CupertinoDatePickerMode.date,
                      minimumYear: 1950,
                      maximumYear: DateTime.now().year + 1,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
