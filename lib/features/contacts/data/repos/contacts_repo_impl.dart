import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final doc = await _firestore.collection('users').doc(userId).get();

      final data = doc.data()!;
      final contactList =
          List<Map<String, dynamic>>.from(data['contacts'] ?? []);
      final contacts = contactList.map((c) => Contact.fromMap(c)).toList();
      print('--------------------------------------------contacts done');
      return Right(contacts);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }
}
