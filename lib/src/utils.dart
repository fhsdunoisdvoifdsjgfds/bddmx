import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'database/friend.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

String dateToString(DateTime date) => DateFormat('MMM dd yyyy').format(date);

DateTime stringToDate(String date) {
  try {
    return DateFormat('MMM dd yyyy').parse(date);
  } catch (_) {
    return DateTime.now();
  }
}

String formatTimestamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(Duration(days: 1));
  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return "Today";
  } else if (date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day) {
    return "Yesterday";
  } else {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}

String calculateAge(String birth) {
  DateTime birthDate = stringToDate(birth);
  DateTime today = DateTime.now();
  int age = today.year - birthDate.year + 1;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }
  return age.toString();
}

List<Friend> sortIncomingBirthdays(List<Friend> friends) {
  return friends
    ..sort((a, b) {
      DateTime dateA = stringToDate(a.birth);
      DateTime dateB = stringToDate(b.birth);
      return dateA.month.compareTo(dateB.month);
    });
}

String convertDate(String date) {
  DateTime parsedDate = DateFormat('MMM dd yyyy').parse(date);
  const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  final String month = monthNames[parsedDate.month - 1];
  final String formattedDate = "$month - ${parsedDate.day}";
  return formattedDate;
}

bool getActive(List<String> strings) {
  for (String string in strings) {
    if (string.isEmpty) return false;
  }
  return true;
}

Future<XFile> pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return XFile('');
    return image;
  } catch (e) {
    return XFile('');
  }
}
