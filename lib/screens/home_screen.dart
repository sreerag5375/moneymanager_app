import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money/widgets/drawer.dart';

import '../widgets/bottom_navigation.dart';
import '../db/db_functions/transaction_db_functions.dart';
import '../model/transaction_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  getTotalBalance(List<TransactionModel> data) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    data.forEach((element) {
      if (element.type == 'Income') {
        totalBalance += element.amount;
        totalIncome += element.amount;
      } else {
        totalBalance -= element.amount;
        totalExpense += element.amount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getTransactions();
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: Icon(
                  Icons.menu,
                  color: Colors.deepPurple.shade300,
                  size: 28,
                ));
          }),
          leadingWidth: 24,
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Hey',
                style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                ' Sreerag',
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 21.0,
                ),
              ),
            ],
          ),
        ),
        //drawer: const DrawerWidget(),
        backgroundColor: Colors.grey[200],
        body: ValueListenableBuilder(
            valueListenable: transactionNotifier,
            builder: (BuildContext context, List<TransactionModel> newList,
                Widget? _) {
              getTotalBalance(newList);
              return SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //total money card
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepPurple,
                                  Colors.deepPurpleAccent
                                ],
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    'Total Balance',
                                    style: GoogleFonts.raleway(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                //

                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  totalBalance.toString(),
                                  style: GoogleFonts.barlow(
                                      fontSize: 33.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                //

                                //
                                const SizedBox(
                                  height: 10.0,
                                ),
                                //

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IncomeExpenseCard(
                                        labelName: 'Income',
                                        amount: totalIncome,
                                        iconName: Icons.arrow_upward,
                                        arrowColor: Colors.green.shade800,
                                      ),
                                      IncomeExpenseCard(
                                        labelName: 'Expense',
                                        amount: totalExpense,
                                        iconName: Icons.arrow_downward,
                                        arrowColor: Colors.red.shade800,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //

                      //
                      const SizedBox(
                        height: 16.0,
                      ),
                      //

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 18.0, bottom: 18.0),
                        child: Text(
                          'Recent Transactions',
                          style: GoogleFonts.raleway(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),

                      //
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final list = newList[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    //type
                                    leading: Column(
                                      children: [
                                        //CircleAvatar(
                                        // backgroundColor: list.type == 'Income'
                                        //     ? Colors.green[800]
                                        //     : Colors.red[700],
                                        // child:
                                        Icon(
                                          list.type == 'Income'
                                              ? Icons.arrow_circle_up
                                              : Icons.arrow_circle_down,
                                          color: list.type == 'Income'
                                              ? Colors.green[600]
                                              : Colors.red[600],
                                          size: 30,
                                        ),
                                        //),
                                        Expanded(
                                            child: Text(
                                          list.type,
                                          style:
                                              GoogleFonts.raleway(fontSize: 13),
                                        ))
                                      ],
                                    ),
                                    //

                                    //amount
                                    title: Text(
                                      list.amount.toString(),
                                      style: GoogleFonts.barlow(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    //

                                    //description
                                    subtitle: Text(list.description),
                                    //

                                    //date
                                    trailing: Column(
                                      children: [
                                        Text(
                                          formatDate(list.time),
                                          style:
                                              GoogleFonts.raleway(fontSize: 16),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                              onPressed: () {
                                                try {
                                                  deleteTransaction(list.id!);
                                                } catch (e) {
                                                  print('id not found');
                                                }
                                              },
                                              icon: const Icon(Icons.delete)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 1.0,
                                ),
                            itemCount: newList.length),
                      ),
                    ]),
              );
            }),
        bottomNavigationBar: const BottomNavigation(
          
        ));
  }

  formatDate(DateTime date) {
    String parsed = DateFormat("MMMd").format(date);
    return parsed;
  }

  //income and expense card

}

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({
    super.key,
    required this.labelName,
    required this.amount,
    required this.iconName,
    required this.arrowColor,
  });
  final String labelName;
  final double amount;
  final IconData iconName;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
            child: Icon(
              iconName,
              color: arrowColor,
              size: 34,
            )),
        const SizedBox(
          width: 8.0,
        ),
        Column(
          children: [
            Text(
              labelName,
              style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              amount.toString(),
              style: GoogleFonts.barlow(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            )
          ],
        ),
      ],
    );
  }
}
