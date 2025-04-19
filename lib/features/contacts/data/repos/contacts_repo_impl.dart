import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/models/contact.dart';
import 'package:chat/core/models/user_model.dart';
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
      return Right(contacts);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    }
  }

  Future<Either<Failure, Null>> addContactByPhoneNumber(
      String phoneNumber) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final query = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return Left(ServerFailure(
            'No users exist with this Phone Number. Please try again.'));
      }

      final contactDoc = query.docs.first;
      final contactUser = UserModel.fromMap(contactDoc.id, contactDoc.data());

      if (contactUser.uid == userId) {
        return Left(ServerFailure("You can't add yourself as a contact."));
      }

      final currentUserDoc =
          await _firestore.collection('users').doc(userId).get();
      final data = currentUserDoc.data() ?? {};

      List<dynamic> currentContactsRaw = data['contacts'] ?? [];
      final currentContacts =
          List<Map<String, dynamic>>.from(currentContactsRaw);

      final newContact = {
        'name': contactUser.displayName,
        'phoneNumber': contactUser.phoneNumber,
      };

      final alreadyAdded = currentContacts
          .any((c) => c['phoneNumber'] == newContact['phoneNumber']);

      if (alreadyAdded) {
        return Left(ServerFailure("Contact already added."));
      } else {
        currentContacts.add(newContact);

        await _firestore
            .collection('users')
            .doc(userId)
            .update({'contacts': currentContacts});
      }

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
