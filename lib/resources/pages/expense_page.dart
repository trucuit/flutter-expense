import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/transaction.dart';
import 'package:flutter_app/app/providers/transaction_income_provider.dart';
import 'package:flutter_app/app/providers/transaction_provider.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/pages/history_page.dart';
import 'package:flutter_app/resources/widgets/app_bar_widget.dart';
import 'package:gap/gap.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:provider/provider.dart';

class ExpensePage extends NyStatefulWidget {
  static const path = '/expense';

  ExpensePage({super.key}) : super(path, child: () => _ExpensePageState());
}

class _ExpensePageState extends NyState<ExpensePage> {
  late String type = '';

  @override
  init() async {
    type = widget.data();
  }

  late String valueSelected = '';
  final _amountController = TextEditingController();

  updateValueSelected(String value) {
    value = value.isEmpty ? '' : value;
    final _value = value.isEmpty ? '' : value;

    setState(() {
      _amountController.value = TextEditingValue(text: _value);
      valueSelected = value;
    });
  }

  @override
  Widget view(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final providerIncome = Provider.of<TransactionIncomeProvider>(context);

    handleSubmit() {
      if (type == 'Expense') {
        provider.addTransaction(new TransactionModel(
            amount: double.parse(valueSelected), date: DateTime.now()));
      } else {
        providerIncome.addTransaction(new TransactionModel(
            amount: double.parse(valueSelected), date: DateTime.now()));
      }

      routeTo(HistoryPage.path, data: type);
    }

    return Scaffold(
      appBar: CustomAppBar(titleText: 'Expense'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InvestmentAmountInput(
                          updateValueSelected: updateValueSelected,
                          amountController: _amountController),
                      const Gap(20),
                      InvestmentOptionsGrid(
                        valueSelected: valueSelected,
                        updateValueSelected: updateValueSelected,
                        onChanged: (value) {
                          setState(() {
                            valueSelected = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SubmitButton(
                disabled: valueSelected.isEmpty,
                handleSubmit: handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestmentAmountInput extends StatelessWidget {
  final TextEditingController amountController;
  final Function(String value) updateValueSelected;

  const InvestmentAmountInput(
      {Key? key,
      required this.amountController,
      required this.updateValueSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(39, 64, 52, 0.08),
            blurRadius: 8.0,
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
              hintText: 'Enter amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            onChanged: (value) => {
              updateValueSelected(value),
            },
          ),
        ],
      ),
    );
  }
}

// create data grid
const List<Map<String, dynamic>> investmentOptions = [
  {'value': 10},
  {'value': 20},
  {'value': 30},
  {'value': 40},
  {'value': 50},
  {'value': 60},
  {'value': 70},
  {'value': 80},
  {'value': 90},
  {'value': 100},
];

class InvestmentOptionsGrid extends StatelessWidget {
  final String valueSelected;
  final Function(String value) updateValueSelected;
  const InvestmentOptionsGrid(
      {Key? key,
      required Null Function(dynamic value) onChanged,
      required this.valueSelected,
      required this.updateValueSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: investmentOptions.length,
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      itemBuilder: (context, index) {
        return GestureDetector(
            child: InvestmentOptionCard(
                valueSelected: valueSelected,
                updateValueSelected: updateValueSelected,
                index: index,
                value: investmentOptions[index]['value']));
      },
    );
  }
}

class InvestmentOptionCard extends StatelessWidget {
  final int index;
  final int value;
  final String valueSelected;
  final Function(String value) updateValueSelected;

  const InvestmentOptionCard(
      {Key? key,
      required this.index,
      required this.value,
      required this.valueSelected,
      required this.updateValueSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        updateValueSelected((int.parse(value.toString()) * 1000).toString())
      },
      child: Container(
        decoration: BoxDecoration(
          color: valueSelected.toString() == (value * 1000).toString()
              ? ThemeColor.get(context).primaryAccent
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(39, 64, 52, 0.08),
              blurRadius: 8.0,
              offset: Offset(0.0, 8.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${((value))}K',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final bool disabled;
  final Function() handleSubmit;
  const SubmitButton(
      {Key? key, required this.disabled, required this.handleSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : handleSubmit,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: disabled
              ? Theme.of(context).primaryColor
              : ThemeColor.get(context).primaryAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
