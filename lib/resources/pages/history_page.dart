import 'package:flutter/material.dart';
import 'package:flutter_app/app/providers/transaction_income_provider.dart';
import 'package:flutter_app/app/providers/transaction_provider.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/widgets/app_bar_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:provider/provider.dart';

class HistoryPage extends NyStatefulWidget {
  static const path = '/income';

  HistoryPage({super.key}) : super(path, child: () => _HistoryPageState());
}

class _HistoryPageState extends NyState<HistoryPage> {
  late String type = '';

  @override
  init() async {
    type = widget.data();
  }

  @override
  Widget view(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final providerIncome = Provider.of<TransactionIncomeProvider>(context);

    double totalAmount = provider.totalAmount;
    var transactions = provider.transactions;

    if (type == 'Income') {
      totalAmount = providerIncome.totalAmount;
      transactions = providerIncome.transactions;
    }

    final incomeTextStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: CustomAppBar(titleText: 'List of ${type}'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total ${type}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const Gap(8),
                    Text(
                      formatCurrency(totalAmount).toString(),
                      style:
                          TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    String formattedDate = DateFormat('HH:mm dd/MM/yyyy')
                        .format(transaction.date!);

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFF0F4F4), width: 1.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: const FlutterLogo(size: 36.0),
                        title: Text('Income $index', style: incomeTextStyle),
                        subtitle: Text(formattedDate),
                        trailing: Text(
                          formatCurrency(transaction.amount).toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
