import 'package:firebase_auth/firebase_auth.dart';

class CalendarArgument {
  final User user;

  CalendarArgument(this.user);

  String? get uid {
    return user.uid;
  }
}
