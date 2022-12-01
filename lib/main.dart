import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/model/transaction_model.dart';
import 'package:money/screens/add_transaction.dart';
import 'package:money/screens/home_screen.dart';
import 'package:money/screens/statistic_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
      routes: {
        AddTransactionScreen.routeName: (context) =>
            const AddTransactionScreen(),
        StatisticScreen.route_name: (context) => const StatisticScreen(),
      },
    );
  }
}
