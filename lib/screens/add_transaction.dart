import 'package:flutter/material.dart';
import 'package:money/db/db_functions/transaction_db_functions.dart';
import 'package:money/model/transaction_model.dart';
import 'package:flutter/services.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
  //
  static const routeName = 'add_transaction_screen_route_name';
  //
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  double? amount;
  String? description;
  String type = 'Income';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Transaction',
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel))
              ],
            ),
            //

            //
            const SizedBox(
              height: 30,
            ),
            //

            //
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount...'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  amount = double.parse(value);
                }
              },
            ),
            //

            //
            const SizedBox(
              height: 30,
            ),
            //

            //
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Description...'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  description = value;
                }
              },
            ),
            //

            //
            const SizedBox(
              height: 30,
            ),
            //

            Row(
              children: [
                ChoiceChip(
                  selectedColor: Colors.deepPurple,
                  label: Text(
                    'Income',
                    style: TextStyle(
                        color: type == "Income" ? Colors.white : Colors.black),
                  ),
                  selected: type == "Income" ? true : false,
                  onSelected: ((value) {
                    if (value) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  }),
                ),
                //
                const SizedBox(
                  width: 15.0,
                ),
                //
                ChoiceChip(
                  selectedColor: Colors.deepPurple,
                  label: Text(
                    'Expense',
                    style: TextStyle(
                        color: type == "Expense" ? Colors.white : Colors.black),
                  ),
                  selected: type == "Expense" ? true : false,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        type = 'Expense';
                      });
                    }
                  },
                )
              ],
            ),
            //

            const SizedBox(
              height: 20,
            ),
            //

            //
            TextButton(
                onPressed: () async {
                  final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());

                  if (selectedDate != date) {
                    date = selectedDate!;
                  }
                },
                child: Text('Date')),

            //

            //
            const SizedBox(
              height: 30.0,
            ),
            //

            //
            ElevatedButton(
                onPressed: () {
                  if (amount == null) {
                    snackbarError(context);
                    return;
                  }
                  if (description == null || description!.trim().length <= 0) {
                    snackbarError(context);
                    return;
                  }

                  // print(amount);
                  // print(description);
                  // print(type);
                  // print(date);

                  final model = TransactionModel(
                      amount: amount!,
                      description: description!,
                      type: type,
                      time: date);
                  insertTransaction(model);
                  Navigator.pop(context);
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }

  void snackbarError(BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10.0),
        content: const Text("Please enter valid amount and description")));
  }
}
