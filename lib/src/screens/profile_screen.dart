import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../utils.dart';
import '../controllers/profile/profile_bloc.dart';
import '../widgets/add_photo_button.dart';
import '../widgets/button.dart';
import '../widgets/field.dart';
import '../widgets/image_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/scaffold2.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller1 = TextEditingController(); // image
  final controller2 = TextEditingController(); // name
  final controller3 = TextEditingController(); // surname
  final controller4 = TextEditingController(); // birth

  bool active = false;

  void onChanged() {
    setState(() {
      active = getActive([
        controller1.text,
        controller2.text,
        controller3.text,
        controller4.text,
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

  void onConfirm() {
    context.read<ProfileBloc>().add(ProfileSave(
          image: controller1.text,
          name: controller2.text,
          surname: controller3.text,
          birth: controller4.text,
        ));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileGet());
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            controller1.text = state.image;
            controller2.text = state.name;
            controller3.text = state.surname;
            controller4.text = state.birth;
            onChanged();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Column(
              children: [
                PageTitle(
                  title: 'Profile',
                  back: true,
                ),
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
                  height: 150,
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
                    ],
                  ),
                ),
                Spacer(),
                Button(
                  title: 'Confirm',
                  active: active,
                  onPressed: onConfirm,
                ),
                SizedBox(height: 22),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
