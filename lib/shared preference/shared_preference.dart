import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static late SharedPreferences _sharedPreferences;
  static const String _keyValue = "Task";
  static const String _keyComp = "Completed Task";
  static List<String> allTasks = [];
  static List<String> completedTasks = [];

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setTasks() async {
    await _sharedPreferences.setStringList(_keyValue, allTasks);
  }

  static List<String> getTasks() {
    return _sharedPreferences.getStringList(_keyValue) ?? [];
  }

  static void addData(String task, BuildContext context) {
    allTasks = getTasks();
    allTasks.add(task);
    setTasks().then((value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Has been added successfully"))));
  }

  static Future setCompData() async {
    await _sharedPreferences.setStringList(_keyComp, completedTasks);
  }

  static List<String> getCompData() {
    return _sharedPreferences.getStringList(_keyComp) ?? [];
  }

  static void deleteTask(int index) {
    allTasks = getTasks();
    completedTasks.add(allTasks[index]);
    setCompData();
    allTasks.removeAt(index);
    setTasks();
  }
}
