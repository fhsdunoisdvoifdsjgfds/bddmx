part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileGet extends ProfileEvent {}

class ProfileSave extends ProfileEvent {
  ProfileSave({
    required this.image,
    required this.name,
    required this.surname,
    required this.birth,
  });
  final String image;
  final String name;
  final String surname;
  final String birth;
}
