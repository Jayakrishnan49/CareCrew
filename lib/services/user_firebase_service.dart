import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2/model/user_model.dart';

class UserFirebaseService {
   final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  // // add user

 final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String get userId => _auth.currentUser!.uid;

   CollectionReference get _usersCollection =>
      _firestore.collection('users');

  // CREATE or UPDATE user
  Future<void> createOrUpdateUser(UserModel user) async {
    await _usersCollection.doc(user.userId).set(user.toJson());
  }

  // READ user
  Future<UserModel?> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // UPDATE specific fields
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    await _usersCollection.doc(userId).update(updates);
  }

  // DELETE user
  Future<void> deleteUser(String userId) async {
    await _usersCollection.doc(userId).delete();
  }
}
