part of 'friend_bloc.dart';

@immutable
sealed class FriendState {}

final class FriendInitial extends FriendState {}

final class FriendLoaded extends FriendState {
  FriendLoaded({required this.friends});
  final List<Friend> friends;
}
