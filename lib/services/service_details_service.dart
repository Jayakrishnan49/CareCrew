import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/work_model.dart';

class ServiceDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _worksCollection => _firestore.collection('services');

  // Get all works
  Future<List<WorkModel>> getAllWorks() async {
    final snapshot = await _worksCollection.get();
    return snapshot.docs
        .map((doc) => WorkModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Get specific work
  Future<WorkModel?> getWork(String id) async {
    final doc = await _worksCollection.doc(id).get();
    if (doc.exists) {
      return WorkModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
