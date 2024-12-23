part of 'friend_bloc.dart';

@immutable
sealed class FriendEvent {}

class FriendGet extends FriendEvent {}

class FriendAdd extends FriendEvent {
  FriendAdd({required this.friend});
  final Friend friend;
}

class FriendEdit extends FriendEvent {
  FriendEdit({required this.friend});
  final Friend friend;
}

class FriendDelete extends FriendEvent {
  FriendDelete({required this.friend});
  final Friend friend;
}
