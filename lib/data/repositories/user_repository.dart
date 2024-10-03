import 'package:tango/core/services/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();

  final String _collection = 'users'; // Define the collection name for users

  // Create or update user data
  Future createUser(
      {required String userId, required Map<String, dynamic> userData}) async {
    return await _firestoreService.setDocument(
      collection: _collection,
      docId: userId,
      data: userData,
    );
  }

  // Get a user's data by userId
  Future<Map<String, dynamic>?> getUser({required String userId}) async {
    final docSnapshot = await _firestoreService.getDocument(
      collection: _collection,
      docId: userId,
    );
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    }
    return null;
  }

  // Update specific fields for a user
  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    await _firestoreService.updateDocument(
      collection: _collection,
      docId: userId,
      data: updatedData,
    );
  }

  // Delete a user from Firestore
  Future<void> deleteUser(String userId) async {
    await _firestoreService.deleteDocument(
      collection: _collection,
      docId: userId,
    );
  }

  // Get all users (for listing purposes)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final querySnapshot = await _firestoreService.getCollection(
      collection: _collection,
    );
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
