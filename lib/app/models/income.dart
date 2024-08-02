import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeModel extends ChangeNotifier {
  double _data = 0.0;

  double get data => _data;

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _data = prefs.getDouble('income') ?? 0.0;
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
      await prefs.setDouble('income', _data);
      notifyListeners();
    } catch (e) {
      // Handle the error appropriately
      print('Error saving data: $e');
    }
  }
}
