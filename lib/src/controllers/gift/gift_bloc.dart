import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database.dart';
import '../../database/gift.dart';

part 'gift_event.dart';
part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  GiftBloc() : super(GiftInitial()) {
    on<GiftEvent>(
      (event, emit) => switch (event) {
        GiftGet() => _get(event, emit),
        GiftAdd() => _add(event, emit),
        GiftEdit() => _edit(event, emit),
        GiftDelete() => _delete(event, emit),
      },
    );
  }

  void _get(GiftGet event, Emitter<GiftState> emit) async {
    List<Gift> gifts = await getGifts();
    emit(GiftLoaded(gifts: gifts));
  }

  void _add(GiftAdd event, Emitter<GiftState> emit) async {
    List<Gift> gifts = await getGifts();
    gifts.insert(0, event.gift);
    gifts = await updateGifts(gifts);
    emit(GiftLoaded(gifts: gifts));
  }

  void _edit(GiftEdit event, Emitter<GiftState> emit) async {
    List<Gift> gifts = await getGifts();
    for (Gift gift in gifts) {
      if (gift.id == event.gift.id) {
        gift.title = event.gift.title;
        gift.price = event.gift.price;
        gift.details = event.gift.details;
        gift.notes = event.gift.notes;
      }
    }
    gifts = await updateGifts(gifts);
    emit(GiftLoaded(gifts: gifts));
  }

  void _delete(GiftDelete event, Emitter<GiftState> emit) async {
    List<Gift> gifts = await getGifts();
    gifts.removeWhere((element) => element.id == event.gift.id);
    gifts = await updateGifts(gifts);
    emit(GiftLoaded(gifts: gifts));
  }
}
