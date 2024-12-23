import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/guest/guest_bloc.dart';
import '../utils.dart';
import '../database/guest.dart';
import '../widgets/add_photo_button.dart';
import '../widgets/btn.dart';
import '../widgets/button.dart';
import '../widgets/del_dialog.dart';
import '../widgets/field.dart';
import '../widgets/image_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/scaffold2.dart';

class GuestAddScreen extends StatefulWidget {
  const GuestAddScreen({
    super.key,
    this.guest,
  });

  final Guest? guest;

  @override
  State<GuestAddScreen> createState() => _GuestAddScreenState();
}

class _GuestAddScreenState extends State<GuestAddScreen> {
  final controller1 = TextEditingController(); // image
  final controller2 = TextEditingController(); // name
  final controller3 = TextEditingController(); // surname
  final controller4 = TextEditingController(); // age
  final controller5 = TextEditingController(); // status
  final controller6 = TextEditingController(); // notes
  List<TextEditingController> phones = [TextEditingController()];
  List<TextEditingController> emails = [TextEditingController()];

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

  void onAddEmail() {
    emails.add(TextEditingController());
    onChanged();
  }

  void onRemoveEmail(int index) {
    emails.removeAt(index);
    onChanged();
  }

  void onAdd() {
    final guest = Guest(
      id: widget.guest == null ? getTimestamp() : widget.guest!.id,
      image: controller1.text,
      name: controller2.text,
      surname: controller3.text,
      age: int.parse(controller4.text),
      status: controller5.text,
      notes: controller6.text,
      phones: List.generate(phones.length, (index) => phones[index].text),
      emails: List.generate(emails.length, (index) => emails[index].text),
    );
    if (widget.guest == null) {
      context.read<GuestBloc>().add(GuestAdd(guest: guest));
    } else {
      context.read<GuestBloc>().add(GuestEdit(guest: guest));
    }
    Navigator.pop(context);
  }

  void onDelete() async {
    await showDialog(
      context: context,
      builder: (context) {
        return DelDialog(
          title: 'Delete Guest?',
          onYes: () {
            context.read<GuestBloc>().add(GuestDelete(guest: widget.guest!));
            if (mounted) Navigator.pop(context);
          },
        );
      },
    ).then((value) {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.guest != null) {
      controller1.text = widget.guest!.image;
      controller2.text = widget.guest!.name;
      controller3.text = widget.guest!.surname;
      controller4.text = widget.guest!.age.toString();
      controller5.text = widget.guest!.status;
      controller6.text = widget.guest!.notes;
      phones = List.generate(
        widget.guest!.phones.length,
        (index) => TextEditingController(text: widget.guest!.phones[index]),
      );
      emails = List.generate(
        widget.guest!.emails.length,
        (index) => TextEditingController(text: widget.guest!.emails[index]),
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
    for (var email in emails) {
      email.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: Column(
        children: [
          PageTitle(
            title: 'Add Guest',
            back: true,
            onDelete: widget.guest == null ? null : onDelete,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 20),
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
                        hintText: 'Years',
                        onlyNumber: true,
                        maxLength: 2,
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
                              hintText: 'Add Phone Number',
                              onlyNumber: true,
                              onChanged: onChanged,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ...List.generate(
                  emails.length,
                  (index) {
                    bool last = index == emails.length - 1;

                    return Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 38),
                      color: Color(0xff3CC8FF),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Btn(
                            onPressed: () {
                              last ? onAddEmail() : onRemoveEmail(index);
                            },
                            child: SvgPicture.asset(last
                                ? 'assets/desc_add.svg'
                                : 'assets/desc_remove.svg'),
                          ),
                          Expanded(
                            child: Field(
                              controller: emails[index],
                              hintText: 'Add E-mail',
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
                  title: widget.guest == null ? 'Add guest' : 'Edit guest',
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
