part of 'guest_bloc.dart';

@immutable
sealed class GuestState {}

final class GuestInitial extends GuestState {}

final class GuestLoaded extends GuestState {
  GuestLoaded({required this.guests});
  final List<Guest> guests;
}
