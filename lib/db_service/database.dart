import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/task.dart';

class DataBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  Stream<List<Task>> getTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
    });
  }
}