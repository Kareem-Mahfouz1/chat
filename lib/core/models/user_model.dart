import 'package:chat/core/models/contact.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String? fcmToken;
  final List<Contact> contacts;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    this.fcmToken,
    this.contacts = const [],
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? 'N/A',
      displayName: map['displayName'] ?? 'N/A',
      phoneNumber: map['phoneNumber'] ?? 'N/A',
      fcmToken: map['fcmToken'] ?? 'N/A',
      contacts: (map['contacts'] as List<dynamic>? ?? [])
          .map((c) => Contact.fromMap(Map<String, dynamic>.from(c)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'fcmToken': fcmToken,
      'contacts': contacts.map((c) => c.toMap()).toList(),
    };
  }
}
