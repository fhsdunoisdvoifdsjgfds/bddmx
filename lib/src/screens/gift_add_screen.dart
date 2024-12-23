import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/gift/gift_bloc.dart';
import '../database/gift.dart';
import '../utils.dart';
import '../widgets/add_photo_button.dart';
import '../widgets/btn.dart';
import '../widgets/button.dart';
import '../widgets/field.dart';
import '../widgets/image_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/scaffold2.dart';

class GiftAddScreen extends StatefulWidget {
  const GiftAddScreen({
    super.key,
    this.gift,
  });

  final Gift? gift;

  @override
  State<GiftAddScreen> createState() => _GiftAddScreenState();
}

class _GiftAddScreenState extends State<GiftAddScreen> {
  final controller1 = TextEditingController(); // title
  final controller2 = TextEditingController(); // image
  final controller3 = TextEditingController(); // price
  final controller4 = TextEditingController(); // notes
  List<TextEditingController> descriptions = [TextEditingController()];

  bool active = false;

  void onChanged() {
    setState(() {
      active = getActive([
        controller1.text,
        controller2.text,
        controller3.text,
        controller4.text,
        ...descriptions.map((controller) => controller.text)
      ]);
    });
  }

  void onPickImage() async {
    XFile image = await pickImage();
    if (image.path.isNotEmpty) {
      controller2.text = image.path;
      onChanged();
    }
  }

  void onAddDesc() {
    descriptions.add(TextEditingController());
    onChanged();
  }

  void onRemoveDesc(int index) {
    descriptions.removeAt(index);
    onChanged();
  }

  void onAdd() {
    final gift = Gift(
      id: widget.gift == null ? getTimestamp() : widget.gift!.id,
      title: controller1.text,
      image: controller2.text,
      price: int.parse(controller3.text),
      details: List.generate(
        descriptions.length,
        (index) => descriptions[index].text,
      ),
      notes: controller4.text,
    );
    context.read<GiftBloc>().add(
          widget.gift == null ? GiftAdd(gift: gift) : GiftEdit(gift: gift),
        );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.gift != null) {
      controller1.text = widget.gift!.title;
      controller2.text = widget.gift!.image;
      controller3.text = widget.gift!.price.toString();
      controller4.text = widget.gift!.notes;
      descriptions = List.generate(
        widget.gift!.details.length,
        (index) {
          return TextEditingController(text: widget.gift!.details[index]);
        },
      );
    }
    onChanged();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    for (var description in descriptions) {
      description.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Column(
        children: [
          PageTitle(
            title: widget.gift == null ? 'Add Gift' : 'Edit Gift',
            back: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 20),
                controller2.text.isEmpty
                    ? SvgPicture.asset('assets/no_image.svg')
                    : ImageWidget(image: controller2.text),
                SizedBox(height: 25),
                AddPhotoButton(onPressed: onPickImage),
                SizedBox(height: 22),
                Container(
                  height: 94,
                  color: Color(0xff3CC8FF),
                  child: Column(
                    children: [
                      Field(
                        controller: controller1,
                        hintText: 'Name',
                        onChanged: onChanged,
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        color: Color(0xffD9D9D9),
                      ),
                      SizedBox(height: 10),
                      Field(
                        controller: controller3,
                        hintText: 'Price',
                        onlyNumber: true,
                        maxLength: 6,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'w800',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...List.generate(
                  descriptions.length,
                  (index) {
                    bool last = index == descriptions.length - 1;

                    return Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 38),
                      color: Color(0xff3CC8FF),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Btn(
                            onPressed: () {
                              last ? onAddDesc() : onRemoveDesc(index);
                            },
                            child: SvgPicture.asset(last
                                ? 'assets/desc_add.svg'
                                : 'assets/desc_remove.svg'),
                          ),
                          Expanded(
                            child: Field(
                              controller: descriptions[index],
                              hintText: 'Description',
                              onChanged: onChanged,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  height: 102,
                  color: Color(0xff3CC8FF),
                  child: Field(
                    controller: controller4,
                    hintText: 'Notes',
                    multiline: true,
                    maxLength: 200,
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(height: 38),
                Button(
                  title: widget.gift == null ? 'Add gift' : 'Edit gift',
                  active: active,
                  onPressed: onAdd,
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
