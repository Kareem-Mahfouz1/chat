class Contact {
  final String uid;
  final String name;
  final String phoneNumber;

  Contact({
    required this.uid,
    required this.name,
    required this.phoneNumber,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      uid: map['uid'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
