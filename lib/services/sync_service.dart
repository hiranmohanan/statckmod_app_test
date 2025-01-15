import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:statckmod_app/services/firebase_services.dart';

import '../models/models.dart';
import 'sql_service.dart';

class SyncService {
  final FireColudStoreService _firestoreService = FireColudStoreService();

  Future<void> syncTasks() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      // Fetch tasks from SQLite
      List<Task> localTasks = await DatabaseHelper().getTasks();

      for (var task in localTasks) {
        // Add each local task to Firestore
        await _firestoreService.addTask(task);
        // Optionally delete from local after sync if needed
        await DatabaseHelper().deleteTask(task.id!);
      }

      // You can also fetch new tasks from Firestore if needed and update SQLite.
      // Fetch tasks from Firestores
      List<Task> remoteTasks = await _firestoreService.getTasks();

      for (var task in remoteTasks) {
        // Add each remote task to SQLite
        await DatabaseHelper().insertTask(task);
      }
    }
  }
}
