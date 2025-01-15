import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:statckmod_app/models/models.dart';
import 'package:statckmod_app/services/firebase_services.dart';

class Repository {
  final FireColudStoreService _firestore = FireColudStoreService();
  late Database _database;

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT, dueDate TEXT, priority TEXT, status TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> addTask(task) async {
    if (await _isOnline()) {
      await _firestore.addTask(task);
    } else {
      await _database.insert('tasks', task,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> updateTask(task) async {
    if (await _isOnline()) {
      await _firestore.updateTask(task);
    } else {
      await _database
          .update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
    }
  }

  Future<void> syncTasks() async {
    if (await _isOnline()) {
      final List<Map<String, dynamic>> localTasks =
          await _database.query('tasks');
      for (var task in localTasks) {
        await _firestore.updateTask(task as Task);
      }
      await _database.delete('tasks');
    }
  }

  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    debugPrint('connectivityResult $connectivityResult');
    return connectivityResult != ConnectivityResult.none;
  }
}
