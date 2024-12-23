part of 'bottom_bloc.dart';

@immutable
sealed class BottomState {}

final class BottomInitial extends BottomState {}

final class BottomGuests extends BottomState {}

final class BottomGifts extends BottomState {}

final class BottomSettings extends BottomState {}
