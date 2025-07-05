import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:vidaritodo/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  static const String _storageKey = 'tasks';

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_storageKey);

    if (tasksString != null) {
      final List<dynamic> tasksJson = json.decode(tasksString);
      _tasks = tasksJson.map((json) => Task.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString = json.encode(
      _tasks.map((task) => task.toJson()).toList(),
    );
    await prefs.setString(_storageKey, tasksString);
  }

  Future<void> addTask(String title) async {
    _tasks.add(Task(id: DateTime.now().toString(), title: title));
    notifyListeners();
    await _saveTasks();
  }

  Future<void> toggleTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
    await _saveTasks();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await _saveTasks();
  }
}
