part of 'firebase_services.dart';

class FireColudStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTask(Task task) async {
    final resp = await _db.collection('tasks').add(task.toMap());
    final taskid = resp.id;
    final Task taskdata = task.copyWith(id: taskid);
    await _db.collection('tasks').doc(taskid).set(taskdata.toMap());
    debugPrint('resp $resp');
  }

  Future getTasks() async {
    try {
      final snapshot = await _db.collection('tasks').get();
      return snapshot.docs
          .map((doc) => Task.fromMap({'id': doc.id, ...doc.data()}))
          .toList();
    } on Exception catch (e) {
      return e;
    }
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
  }

  Future<void> syncTasks() async {
    // Implement your logic to sync tasks
  }

  Future addUserName(String name) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await _db.collection('users').doc(user!.uid).set({
        'name': name,
        'profileImage': '',
      });
    } on Exception catch (e) {
      return e;
    }
  }
}
