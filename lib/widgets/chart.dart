import 'package:flutter/material.dart';
import 'package:expenseTracker/models/transaction.dart';
import 'package:expenseTracker/models/groupedTransaction.dart';
import './chartBar.dart';
import 'package:intl/intl.dart';

import 'chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;
  Chart(this._recentTransaction);

  List<GroupedTransaction> get groupedSumTransaction {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalAmount = 0;

      for (int i = 0; i < _recentTransaction.length; i++) {
        if (weekDay.day == _recentTransaction[i].date.day &&
            weekDay.month == _recentTransaction[i].date.month &&
            weekDay.year == _recentTransaction[i].date.year) {
          totalAmount += _recentTransaction[i].amount;
        }
      }
      String weekDayText = "${DateFormat.E().format(weekDay).substring(0, 3)}.";

      // if (weekDay.day == DateTime.now().day && weekDay.month == DateTime.now().month) {
      //   weekDayText = "Today";
      // }
      return GroupedTransaction(amount: totalAmount, day: weekDayText);
    }).reversed.toList();
  }

  double get totalWeekSpending {
    return groupedSumTransaction.fold(
        0.0, (total, element) => total += element.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedSumTransaction
              .map((e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      e.day,
                      e.amount == 0.0 ? 0.0 : e.amount,
                      // ((totalWeekSpending-e.amount)/totalWeekSpending) ==0 ? 0.00: ,
                      totalWeekSpending == 0
                          ? 0.0
                          : e.amount / totalWeekSpending)))
              .toList(),
        ),
      ),
    );
  }
}
