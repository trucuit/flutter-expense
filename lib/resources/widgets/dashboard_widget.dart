import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/transaction.dart';
import 'package:flutter_app/app/providers/transaction_income_provider.dart';
import 'package:flutter_app/app/providers/transaction_provider.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/pages/expense_page.dart';
import 'package:flutter_app/resources/pages/history_page.dart';
import 'package:flutter_app/resources/widgets/pie_chart_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const String state = "dashboard";

  @override
  createState() => _DashboardState();
}

class _DashboardState extends NyState<Dashboard> {
  _DashboardState() {
    stateName = Dashboard.state;
  }

  @override
  init() async {}

  @override
  stateUpdated(dynamic data) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context),
          const Gap(16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalBalance(context),
                  const Gap(16),
                  _buildBalanceAmount(context),
                  const Gap(16),
                  _buildIncomeExpenseRow(context),
                  const Gap(20),
                  _buildTransactionSections(context),
                  PieChartSample2(),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton("Income", context, onPressed: () {
                        routeTo(ExpensePage.path, data: 'Income');
                      }),
                      _buildButton("Expense", context, onPressed: () {
                        routeTo(ExpensePage.path, data: 'Expense');
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, BuildContext context,
      {required Null Function() onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        height: 50,
        decoration: BoxDecoration(
          color: ThemeColor.get(context).primaryAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: 17, color: ThemeColor.get(context).primaryContent)),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogoWithTitle(context),
        Icon(Icons.calendar_month_outlined,
            size: 24, color: ThemeColor.get(context).primaryContent),
      ],
    );
  }

  Widget _buildLogoWithTitle(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(getImageAsset("spendingLogo.svg"),
            width: 28, height: 28),
        const Gap(16),
        Text("Dashboard",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.get(context).primaryAccent)),
      ],
    );
  }

  Widget _buildTotalBalance(BuildContext context) {
    return Text("Total Balance",
        style: TextStyle(
            fontSize: 17, color: ThemeColor.get(context).primaryContent));
  }

  Widget _buildBalanceAmount(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final providerIncome = Provider.of<TransactionIncomeProvider>(context);

    final expenseVal = provider.totalAmount;
    final incomeVal = providerIncome.totalAmount;

    final totalBalance = incomeVal - expenseVal;

    return Text(formatCurrency(totalBalance).toString(),
        style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            color: ThemeColor.get(context).primaryContent));
  }

  Widget _buildIncomeExpenseRow(BuildContext context) {
    return Row(
      children: [
        _buildIncomeColumn(context),
        const Gap(16),
        _buildExpenseColumn(context),
      ],
    );
  }

  Widget _buildIncomeColumn(BuildContext context) {
    final provider = Provider.of<TransactionIncomeProvider>(context);

    return Column(
      children: [
        _buildRowWithIcon("Income", Icons.arrow_upward, context),
        const Gap(8),
        Text(formatCurrency(provider.totalAmount).toString(),
            style: TextStyle(
                fontSize: 17, color: ThemeColor.get(context).primaryContent)),
      ],
    );
  }

  Widget _buildExpenseColumn(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Column(
      children: [
        _buildRowWithIcon("Expense", Icons.arrow_downward, context),
        const Gap(8),
        Text(formatCurrency(provider.totalAmount).toString(),
            style: TextStyle(
                fontSize: 17, color: ThemeColor.get(context).primaryContent)),
      ],
    );
  }

  Widget _buildRowWithIcon(String title, IconData icon, BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 17, color: ThemeColor.get(context).primaryContent)),
        const Gap(8),
        Icon(icon, color: ThemeColor.get(context).primaryAccent),
      ],
    );
  }

  Widget _buildTransactionSections(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final providerIncome = Provider.of<TransactionIncomeProvider>(context);
    // get the latest transaction
    final transaction = provider.transactions.isEmpty
        ? new TransactionModel(amount: 0, date: DateTime.now())
        : provider.transactions.first;

    final transactionIncome = providerIncome.transactions.isEmpty
        ? new TransactionModel(amount: 0, date: null)
        : providerIncome.transactions.first;

    return Row(
      children: [
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                routeTo(HistoryPage.path, data: 'Income');
              },
              child: Column(
                children: [
                  _buildTransactionContainer(
                      "Latest received",
                      formatCurrency(transactionIncome.amount).toString(),
                      transactionIncome.date == null
                          ? ""
                          : DateFormat('HH:mm dd/MM/yyyy')
                              .format(transactionIncome.date!),
                      context),
                ],
              ),
            )),
        const Gap(16),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              routeTo(HistoryPage.path, data: 'Expense');
            },
            child: Column(
              children: [
                _buildTransactionContainer(
                    "Latest sent",
                    formatCurrency(transaction.amount).toString(),
                    transaction.date == null
                        ? ""
                        : DateFormat('HH:mm dd/MM/yyyy')
                            .format(transaction.date!),
                    context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTransactionContainer(
      String text, String amount, String date, BuildContext context) {
    return Container(
      height: 90, // Adjust based on content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(39, 64, 52, 0.08),
            offset: Offset(0, 8),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(text),
                  Text(amount),
                  Text(date),
                ],
              ),
            ),
          ),
          Icon(Icons.arrow_right,
              size: 24, color: ThemeColor.get(context).primaryContent),
        ],
      ),
    );
  }
}
