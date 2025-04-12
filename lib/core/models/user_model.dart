class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? 'N/A',
      displayName: map['displayName'] ?? 'N/A',
      phoneNumber: map['phoneNumber'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    };
  }
}
