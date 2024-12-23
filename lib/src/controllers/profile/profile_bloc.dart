import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileGet>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String image = prefs.getString('image') ?? '';
      String name = prefs.getString('name') ?? '';
      String surname = prefs.getString('surname') ?? '';
      String birth = prefs.getString('birth') ?? '';
      emit(ProfileLoaded(
        image: image,
        name: name,
        surname: surname,
        birth: birth,
      ));
    });

    on<ProfileSave>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', event.image);
      await prefs.setString('name', event.name);
      await prefs.setString('surname', event.surname);
      await prefs.setString('birth', event.birth);

      emit(ProfileLoaded(
        image: event.image,
        name: event.name,
        surname: event.surname,
        birth: event.birth,
      ));
    });
  }
}
