import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/expense.dart';
import 'package:flutter_app/app/models/income.dart';
import 'package:flutter_app/app/providers/transaction_income_provider.dart';
import 'package:flutter_app/app/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IncomeModel()..loadData()),
        ChangeNotifierProvider(create: (context) => ExpenseModel()..loadData()),
        ChangeNotifierProvider(
            create: (context) => TransactionProvider()..loadTransactions()),
        ChangeNotifierProvider(
            create: (context) =>
                TransactionIncomeProvider()..loadTransactions()),
      ],
      child: AppBuild(
        navigatorKey: NyNavigator.instance.router.navigatorKey,
        onGenerateRoute: nylo.router!.generator(),
        debugShowCheckedModeBanner: false,
        initialRoute: nylo.getInitialRoute(),
        navigatorObservers: nylo.getNavigatorObservers(),
      ),
    ),
  );
}
