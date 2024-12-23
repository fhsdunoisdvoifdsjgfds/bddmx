import 'package:hive_flutter/hive_flutter.dart';

class Friend {
  Friend({
    required this.id,
    required this.image,
    required this.name,
    required this.surname,
    required this.birth,
    required this.status,
    required this.notes,
    required this.phones,
  });

  final int id;
  String image;
  String name;
  String surname;
  String birth;
  String status;
  String notes;
  List<String> phones;
}

class FriendAdap extends TypeAdapter<Friend> {
  @override
  final typeId = 1;

  @override
  Friend read(BinaryReader reader) {
    return Friend(
      id: reader.read(),
      image: reader.read(),
      name: reader.read(),
      surname: reader.read(),
      birth: reader.read(),
      status: reader.read(),
      notes: reader.read(),
      phones: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Friend obj) {
    writer.write(obj.id);
    writer.write(obj.image);
    writer.write(obj.name);
    writer.write(obj.surname);
    writer.write(obj.birth);
    writer.write(obj.status);
    writer.write(obj.notes);
    writer.write(obj.phones);
  }
}
