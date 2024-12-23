part of 'guest_bloc.dart';

@immutable
sealed class GuestEvent {}

class GuestGet extends GuestEvent {}

class GuestAdd extends GuestEvent {
  GuestAdd({required this.guest});
  final Guest guest;
}

class GuestEdit extends GuestEvent {
  GuestEdit({required this.guest});
  final Guest guest;
}

class GuestDelete extends GuestEvent {
  GuestDelete({required this.guest});
  final Guest guest;
}
