part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  ProfileLoaded({
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
