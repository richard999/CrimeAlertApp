import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CrimeAlertFirebaseUser {
  CrimeAlertFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CrimeAlertFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CrimeAlertFirebaseUser> crimeAlertFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CrimeAlertFirebaseUser>(
            (user) => currentUser = CrimeAlertFirebaseUser(user));
