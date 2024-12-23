import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/friend/friend_bloc.dart';
import '../database/friend.dart';
import '../utils.dart';
import '../widgets/add_photo_button.dart';
import '../widgets/btn.dart';
import '../widgets/button.dart';
import '../widgets/field.dart';
import '../widgets/image_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/scaffold2.dart';

class FriendAddScreen extends StatefulWidget {
  const FriendAddScreen({super.key, this.friend});

  final Friend? friend;

  @override
  State<FriendAddScreen> createState() => _FriendAddScreenState();
}

class _FriendAddScreenState extends State<FriendAddScreen> {
  final controller1 = TextEditingController(); // image
  final controller2 = TextEditingController(); // name
  final controller3 = TextEditingController(); // surname
  final controller4 = TextEditingController(); // birth
  final controller5 = TextEditingController(); // status
  final controller6 = TextEditingController(); // notes
  List<TextEditingController> phones = [TextEditingController()];

  bool active = false;

  void onChanged() {
    setState(() {
      active = getActive([
        controller1.text,
        controller2.text,
        controller3.text,
        controller4.text,
        controller5.text,
        controller6.text,
        ...phones.map((controller) => controller.text)
      ]);
    });
  }

  void onPickImage() async {
    XFile image = await pickImage();
    if (image.path.isNotEmpty) {
      controller1.text = image.path;
      onChanged();
    }
  }

  void onAddPhone() {
    phones.add(TextEditingController());
    onChanged();
  }

  void onRemovePhone(int index) {
    phones.removeAt(index);
    onChanged();
  }

  void onAdd() {
    final friend = Friend(
      id: widget.friend == null ? getTimestamp() : widget.friend!.id,
      image: controller1.text,
      name: controller2.text,
      surname: controller3.text,
      birth: controller4.text,
      status: controller5.text,
      notes: controller6.text,
      phones: List.generate(phones.length, (index) => phones[index].text),
    );
    context.read<FriendBloc>().add(
          widget.friend == null
              ? FriendAdd(friend: friend)
              : FriendEdit(friend: friend),
        );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.friend != null) {
      controller1.text = widget.friend!.image;
      controller2.text = widget.friend!.name;
      controller3.text = widget.friend!.surname;
      controller4.text = widget.friend!.birth;
      controller5.text = widget.friend!.status;
      controller6.text = widget.friend!.notes;
      phones = List.generate(
        widget.friend!.phones.length,
        (index) => TextEditingController(text: widget.friend!.phones[index]),
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
    controller5.dispose();
    controller6.dispose();
    for (var phone in phones) {
      phone.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Column(
        children: [
          PageTitle(
            title: widget.friend == null ? 'Add friend' : 'Edit friend',
            back: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 16),
                ImageWidget(
                  image: controller1.text,
                  height: 90,
                  asset: 'profile',
                ),
                SizedBox(height: 10),
                AddPhotoButton(onPressed: onPickImage),
                SizedBox(height: 22),
                Container(
                  height: 193,
                  color: Color(0xff3CC8FF),
                  child: Column(
                    children: [
                      Field(
                        controller: controller2,
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
                        hintText: 'Last Name',
                        onChanged: onChanged,
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        color: Color(0xffD9D9D9),
                      ),
                      SizedBox(height: 10),
                      Field(
                        controller: controller4,
                        hintText: 'Date of bith',
                        datePicker: true,
                        onChanged: onChanged,
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        color: Color(0xffD9D9D9),
                      ),
                      SizedBox(height: 10),
                      Field(
                        controller: controller5,
                        hintText: 'Status',
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 38),
                ...List.generate(
                  phones.length,
                  (index) {
                    bool last = index == phones.length - 1;

                    return Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 38),
                      color: Color(0xff3CC8FF),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Btn(
                            onPressed: () {
                              last ? onAddPhone() : onRemovePhone(index);
                            },
                            child: SvgPicture.asset(last
                                ? 'assets/desc_add.svg'
                                : 'assets/desc_remove.svg'),
                          ),
                          Expanded(
                            child: Field(
                              controller: phones[index],
                              hintText: 'Phone',
                              onlyNumber: true,
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
                    controller: controller6,
                    hintText: 'Notes',
                    multiline: true,
                    maxLength: 200,
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(height: 38),
                Button(
                  title: widget.friend == null ? 'Add friend' : 'Edit friend',
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
