import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textEnteredTitle = TextEditingController();
  final _textEnteredAmount = TextEditingController();
  DateTime dateEntered;

  void _addTransactionOnSubmit() {
    if (_textEnteredAmount.text.isEmpty) {
      return;
    }
    String enteredTitle = _textEnteredTitle.text;
    double enteredAmount = double.parse(_textEnteredAmount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0.00 || dateEntered == null) {
      return;
    }
    widget.addNewTransaction(DateTime.now().millisecondsSinceEpoch.toString(),
        enteredTitle, enteredAmount, dateEntered);
    Navigator.of(context).pop();
  }

  void getPickedDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateEntered = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textEnteredTitle,
            onSubmitted: (_) => _addTransactionOnSubmit,
            decoration: InputDecoration(
              labelText: "Title",
            ),
          ),
          TextField(
            controller: _textEnteredAmount,
            onSubmitted: (_) => _addTransactionOnSubmit,
            decoration: InputDecoration(
              labelText: "Amount",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                dateEntered != null
                    ? "Date Choosen: ${DateFormat.yMd().format(dateEntered)}"
                    : "No Date Picked",
                style: TextStyle(
                  color:Theme.of(context).primaryColor,
                ),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: getPickedDate,
                child: Text(dateEntered == null
                    ? "Choose Date"
                    : "Change Selected Date"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Cencel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              RaisedButton(
                child: Text("Add", style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: _addTransactionOnSubmit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
