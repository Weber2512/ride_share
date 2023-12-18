import 'package:intl_phone_field/phone_number.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class UserDetails {
  const UserDetails(
      {required this.firstName,
      required this.lastName,
      required this.contact,
      required this.date,
      required this.emial,
      required this.password});
  final String emial;
  final PhoneNumber contact;
  final String firstName;
  final String lastName;
  final String password;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}

class LoginDetailsmodel {
  const LoginDetailsmodel({required this.username, required this.password});
  final String username;
  final String password;
}
