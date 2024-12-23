import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database.dart';
import '../../database/friend.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc() : super(FriendInitial()) {
    on<FriendEvent>(
      (event, emit) => switch (event) {
        FriendGet() => _get(event, emit),
        FriendAdd() => _add(event, emit),
        FriendEdit() => _edit(event, emit),
        FriendDelete() => _delete(event, emit),
      },
    );
  }

  void _get(FriendGet event, Emitter<FriendState> emit) async {
    List<Friend> friends = await getFriends();
    emit(FriendLoaded(friends: friends));
  }

  void _add(FriendAdd event, Emitter<FriendState> emit) async {
    List<Friend> friends = await getFriends();
    friends.insert(0, event.friend);
    friends = await updateFriends(friends);
    emit(FriendLoaded(friends: friends));
  }

  void _edit(FriendEdit event, Emitter<FriendState> emit) async {
    List<Friend> friends = await getFriends();
    for (Friend friend in friends) {
      if (friend.id == event.friend.id) {
        friend.image = event.friend.image;
        friend.name = event.friend.name;
        friend.surname = event.friend.surname;
        friend.birth = event.friend.birth;
        friend.status = event.friend.status;
        friend.notes = event.friend.notes;
        friend.phones = event.friend.phones;
      }
    }
    friends = await updateFriends(friends);
    emit(FriendLoaded(friends: friends));
  }

  void _delete(FriendDelete event, Emitter<FriendState> emit) async {
    List<Friend> friends = await getFriends();
    friends.removeWhere((element) => element.id == event.friend.id);
    friends = await updateFriends(friends);
    emit(FriendLoaded(friends: friends));
  }
}
