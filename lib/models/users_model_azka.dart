import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelAz {
  final String uidAz;
  final String emailAz;
  final String usernameAz;
  final int balanceAz;
  final DateTime createdAtAz;

  UserModelAz({
    required this.uidAz,
    required this.emailAz,
    required this.usernameAz,
    required this.balanceAz,
    required this.createdAtAz,
  });

  factory UserModelAz.fromMapAz(Map<String, dynamic> map) {
    return UserModelAz(
      uidAz: map['uid'],
      emailAz: map['email'],
      usernameAz: map['username'],
      balanceAz: map['balance'],
      createdAtAz: (map['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMapAz() {
    return {
      'uid': uidAz,
      'email': emailAz,
      'username': usernameAz,
      'balance': balanceAz,
      'created_at': createdAtAz,
    };
  }
}
