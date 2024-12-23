part of 'gift_bloc.dart';

@immutable
sealed class GiftState {}

final class GiftInitial extends GiftState {}

final class GiftLoaded extends GiftState {
  GiftLoaded({required this.gifts});
  final List<Gift> gifts;
}
