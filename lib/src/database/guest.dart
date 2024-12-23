import 'package:hive_flutter/hive_flutter.dart';

class Guest {
  Guest({
    required this.id,
    required this.image,
    required this.name,
    required this.surname,
    required this.age,
    required this.status,
    required this.notes,
    required this.phones,
    required this.emails,
  });

  final int id;
  String image;
  String name;
  String surname;
  int age;
  String status;
  String notes;
  List<String> phones;
  List<String> emails;
}

class GuestAdap extends TypeAdapter<Guest> {
  @override
  final typeId = 2;

  @override
  Guest read(BinaryReader reader) {
    return Guest(
      id: reader.read(),
      image: reader.read(),
      name: reader.read(),
      surname: reader.read(),
      age: reader.read(),
      status: reader.read(),
      notes: reader.read(),
      phones: reader.read(),
      emails: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Guest obj) {
    writer.write(obj.id);
    writer.write(obj.image);
    writer.write(obj.name);
    writer.write(obj.surname);
    writer.write(obj.age);
    writer.write(obj.status);
    writer.write(obj.notes);
    writer.write(obj.phones);
    writer.write(obj.emails);
  }
}
