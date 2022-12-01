import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/transaction_model.dart';

ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

//insertData

Future<void> insertTransaction(TransactionModel value) async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');

  final key = await transactionDb.add(value);

  value.id = key;

  getTransactions();

  print(value.toString());
}

//

//getData

Future<void> getTransactions() async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');

  transactionNotifier.value.clear();

  transactionNotifier.value.addAll(transactionDb.values);

  transactionNotifier.notifyListeners();
}

Future<void> deleteTransaction(int id) async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');
  transactionDb.delete(id);
  getTransactions();
}
