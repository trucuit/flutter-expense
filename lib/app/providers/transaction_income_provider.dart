import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TransactionIncomeProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  Future<void> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? transactionsString = prefs.getString('transactionsIncome');
      if (transactionsString != null) {
        List<dynamic> jsonList = json.decode(transactionsString);
        _transactions =
            jsonList.map((json) => TransactionModel.fromJson(json)).toList();
      }
      notifyListeners();
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      _transactions.add(transaction);
      await _saveTransactions();
    } catch (e) {}
  }

  Future<void> _saveTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String transactionsString =
          json.encode(_transactions.map((t) => t.toJson()).toList());
      await prefs.setString('transactions', transactionsString);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> clearTransactions() async {
    try {
      _transactions.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('transactions'); // Remove the key
      notifyListeners();
    } catch (e) {}
  }

  double get totalAmount {
    return _transactions.fold(
        0, (sum, transaction) => sum + transaction.amount);
  }
}
