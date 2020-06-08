import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function removeTransaction;
  TransactionList(this.userTransaction, this.removeTransaction);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => userTransaction.length == 0
          ? Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.09,
                  ),
                  Text(
                    "No Transaction Found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/panda.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: userTransaction.map((tx) {
                return TransactionItem(
                    key: ValueKey(tx.id),
                    userTransaction: tx,
                    removeTransaction: removeTransaction,
                    constraints: constraints);
              }).toList(),
            ),
    );
  }
}
