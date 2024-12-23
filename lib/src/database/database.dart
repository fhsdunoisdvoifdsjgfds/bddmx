import 'package:hive_flutter/hive_flutter.dart';

import 'gift.dart';
import 'friend.dart';
import 'guest.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('bday_balloon');
  Hive.registerAdapter(GiftAdap());
  Hive.registerAdapter(FriendAdap());
  Hive.registerAdapter(GuestAdap());
}

Future<List<Gift>> getGifts() async {
  final box = await Hive.openBox('bday_balloon');
  List data = box.get('gifts') ?? [];
  return data.cast<Gift>();
}

Future<List<Gift>> updateGifts(List<Gift> gifts) async {
  final box = await Hive.openBox('bday_balloon');
  box.put('gifts', gifts);
  return await box.get('gifts');
}

Future<List<Friend>> getFriends() async {
  final box = await Hive.openBox('bday_balloon');
  List data = box.get('friends') ?? [];
  return data.cast<Friend>();
}

Future<List<Friend>> updateFriends(List<Friend> friends) async {
  final box = await Hive.openBox('bday_balloon');
  box.put('friends', friends);
  return await box.get('friends');
}

Future<List<Guest>> getGuests() async {
  final box = await Hive.openBox('bday_balloon');
  List data = box.get('guests') ?? [];
  return data.cast<Guest>();
}

Future<List<Guest>> updateGuests(List<Guest> guests) async {
  final box = await Hive.openBox('bday_balloon');
  box.put('guests', guests);
  return await box.get('guests');
}
