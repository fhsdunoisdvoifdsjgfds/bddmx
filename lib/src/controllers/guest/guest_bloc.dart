import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database.dart';
import '../../database/guest.dart';

part 'guest_event.dart';
part 'guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  GuestBloc() : super(GuestInitial()) {
    on<GuestEvent>(
      (event, emit) => switch (event) {
        GuestGet() => _get(event, emit),
        GuestAdd() => _add(event, emit),
        GuestEdit() => _edit(event, emit),
        GuestDelete() => _delete(event, emit),
      },
    );
  }

  void _get(GuestGet event, Emitter<GuestState> emit) async {
    List<Guest> guests = await getGuests();
    emit(GuestLoaded(guests: guests));
  }

  void _add(GuestAdd event, Emitter<GuestState> emit) async {
    List<Guest> guests = await getGuests();
    guests.insert(0, event.guest);
    guests = await updateGuests(guests);
    emit(GuestLoaded(guests: guests));
  }

  void _edit(GuestEdit event, Emitter<GuestState> emit) async {
    List<Guest> guests = await getGuests();
    for (Guest guest in guests) {
      if (guest.id == event.guest.id) {
        guest.image = event.guest.image;
        guest.name = event.guest.name;
        guest.surname = event.guest.surname;
        guest.age = event.guest.age;
        guest.status = event.guest.status;
        guest.notes = event.guest.notes;
        guest.phones = event.guest.phones;
        guest.emails = event.guest.emails;
      }
    }
    guests = await updateGuests(guests);
    emit(GuestLoaded(guests: guests));
  }

  void _delete(GuestDelete event, Emitter<GuestState> emit) async {
    List<Guest> guests = await getGuests();
    guests.removeWhere((element) => element.id == event.guest.id);
    guests = await updateGuests(guests);
    emit(GuestLoaded(guests: guests));
  }
}
