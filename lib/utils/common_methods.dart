

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Common_Methods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getDisplayName() {
    User? user = _auth.currentUser;
    String displayName = user?.displayName ?? "N/A";
    return displayName;
  }

  String get_uid() {
    User? user = _auth.currentUser;
    String uid = user?.uid ?? "N/A";
    return uid;
  }


  String get_current_day() {
    DateTime now = DateTime.now();
    String formattedDay = DateFormat('EEEE').format(now);
    print(formattedDay);
    return formattedDay;
  }


}