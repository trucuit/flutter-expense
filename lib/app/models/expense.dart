import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseModel extends ChangeNotifier {
  double _data = 0.0;

  double get data => _data;

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _data = prefs.getDouble('expense') ?? 0.0;
      notifyListeners();
    } catch (e) {
      // Handle the error appropriately
      print('Error loading data: $e');
    }
  }

  Future<void> saveData(double value) async {
    try {
      _data = value;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('expense', _data);
      notifyListeners();
    } catch (e) {
      // Handle the error appropriately
      print('Error saving data: $e');
    }
  }
}
