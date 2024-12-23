part of 'gift_bloc.dart';

@immutable
sealed class GiftEvent {}

class GiftGet extends GiftEvent {}

class GiftAdd extends GiftEvent {
  GiftAdd({required this.gift});
  final Gift gift;
}

class GiftEdit extends GiftEvent {
  GiftEdit({required this.gift});
  final Gift gift;
}

class GiftDelete extends GiftEvent {
  GiftDelete({required this.gift});
  final Gift gift;
}
