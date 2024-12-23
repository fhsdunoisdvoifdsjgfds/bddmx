import 'package:hive_flutter/hive_flutter.dart';

class Gift {
  Gift({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.details,
    required this.notes,
  });

  final int id;
  String title;
  String image;
  int price;
  List<String> details;
  String notes;
}

class GiftAdap extends TypeAdapter<Gift> {
  @override
  final typeId = 0;

  @override
  Gift read(BinaryReader reader) {
    return Gift(
      id: reader.read(),
      title: reader.read(),
      image: reader.read(),
      price: reader.read(),
      details: reader.read(),
      notes: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Gift obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.image);
    writer.write(obj.price);
    writer.write(obj.details);
    writer.write(obj.notes);
  }
}
