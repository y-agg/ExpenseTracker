import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../models/description.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.constraints,
    @required this.userTransaction,
    @required this.removeTransaction,
  }):super(key:key);
  final BoxConstraints constraints;
  final Transaction userTransaction;
  final Function removeTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color colorSelected;
  @override
  void initState() {
    const colorsList = [
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.cyan,
      Colors.indigo,
      Colors.pink,
      Colors.green,
      Colors.black,
    ];
    colorSelected = colorsList[Random().nextInt(colorsList.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorSelected,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                "\₹ ${widget.userTransaction.amount}",
                style: MetaInfo.textColor,
              ),
            ),
          ),
        ),
        title: Text(widget.userTransaction.title),
        subtitle: Text(DateFormat.yMMMd().format(widget.userTransaction.date)),
        trailing: widget.constraints.maxWidth > 421
            ? FlatButton.icon(
                onPressed: () =>
                    widget.removeTransaction(widget.userTransaction.id),
                icon: Icon(Icons.delete),
                label: Text("Delete"),
              )
            : IconButton(
                onPressed: () =>
                    widget.removeTransaction(widget.userTransaction.id),
                icon: Icon(Icons.delete),
                color: MetaInfo.deleteIconColor,
              ),
      ),
    );
  }
}
