/*________________________________________
***************TO DO LIST*****************
1̶.̶ A̶d̶d̶ T̶r̶a̶n̶s̶a̶c̶t̶i̶o̶n̶ L̶i̶s̶t̶,̶ N̶e̶w̶ T̶r̶a̶s̶n̶a̶c̶t̶i̶o̶n̶,̶ a̶n̶d̶ C̶h̶a̶r̶t̶.̶ 
2̶.̶ C̶o̶n̶v̶e̶r̶t̶ N̶e̶w̶ T̶r̶a̶n̶s̶a̶c̶t̶i̶o̶n̶ i̶n̶ b̶o̶t̶t̶o̶m̶M̶o̶d̶a̶l̶S̶h̶e̶e̶t̶.̶
3̶.̶ S̶p̶l̶i̶t̶s̶ W̶i̶d̶g̶e̶t̶ i̶n̶t̶o̶ f̶i̶l̶e̶s̶.̶
4̶.̶ C̶r̶e̶a̶t̶e̶ L̶o̶g̶i̶c̶ t̶o̶ s̶h̶o̶w̶ T̶r̶a̶n̶s̶a̶c̶t̶i̶o̶n̶ c̶h̶a̶r̶t̶ o̶f̶ l̶a̶s̶t̶ 7̶ d̶a̶y̶s̶.̶ 
5̶.̶ I̶m̶p̶r̶o̶v̶e̶ O̶v̶e̶r̶a̶l̶l̶ S̶t̶y̶l̶i̶n̶g̶ o̶f̶ t̶h̶e̶ s̶h̶e̶e̶t̶.̶
6̶.̶ a̶d̶d̶ R̶e̶s̶p̶o̶n̶s̶i̶v̶e̶n̶e̶s̶s̶ a̶n̶d̶ a̶d̶a̶p̶t̶i̶v̶e̶n̶e̶s̶s̶ i̶n̶ t̶h̶e̶ a̶p̶p̶l̶i̶c̶a̶t̶i̶o̶n̶ (̶S̶p̶e̶c̶i̶a̶l̶l̶y̶ i̶n̶ f̶o̶r̶ l̶a̶n̶d̶s̶c̶a̶p̶e̶ m̶o̶d̶e̶)̶.̶  
7. Connect transaction to local database to Store Transaction.
________________________________________*/

import 'package:expenseTracker/models/transaction.dart';
import 'package:flutter/material.dart';
import './models/description.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_List.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MetaInfo.title,
      theme: ThemeData(
        fontFamily: "Arvo",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.amber,
        buttonColor: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactionList = [
    // Transaction(
    //   id: DateTime.now().subtract(Duration(days: 1)).toString(),
    //   title: "One Hundred Only",
    //   amount: 100.00,
    //   date: DateTime.now().subtract(Duration(days: 1)),
    // ),
    // Transaction(
    //   id: DateTime.now().subtract(Duration(days: 2)).toString(),
    //   title: "Two Hundred Only",
    //   amount: 200.00,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
    // Transaction(
    //   id: DateTime.now().subtract(Duration(days: 3)).toString(),
    //   title: "Five Hundred Only",
    //   amount: 500.00,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transaction(
    //   id: DateTime.now().subtract(Duration(days: 4)).toString(),
    //   title: "Six Hundred Only",
    //   amount: 600.00,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
  ];

  void _removeUserTransaction(String id) {
    setState(() {
      userTransactionList.removeWhere((index) => index.id == id);
    });
  }

  void adduserTransaction(
      String newId, String newTitle, double newAmount, DateTime newDate) {
    Transaction newTx = Transaction(
        id: newId, title: newTitle, amount: newAmount, date: newDate);
    setState(() {
      userTransactionList.add(newTx);
    });
  }

  void displayBottomUpModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(adduserTransaction),
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return userTransactionList
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();
  }

  bool switchState = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    var appBarVar = AppBar(
      title: Text(
        MetaInfo.title,
        style: TextStyle(fontFamily: "Arvo", fontStyle: FontStyle.italic),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => {displayBottomUpModalSheet(context)},
            icon: Icon(
              Icons.add_circle,
            )),
      ],
    );
    return Scaffold(
      appBar: appBarVar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Show Chart"),Switch.adaptive(
                    value: switchState,
                    onChanged: (val) {
                      setState(() {
                        switchState = val;
                      });
                    },
                  )],
                ),
              if (isLandscape)
                switchState
                    ? Container(
                        height: (mediaQuery.size.height -
                                mediaQuery.padding.top -
                                appBarVar.preferredSize.height) *
                            0.7,
                        child: Chart(_recentTransaction),
                      )
                    : Container(
                        height: (mediaQuery.size.height -
                                mediaQuery.padding.top -
                                appBarVar.preferredSize.height) *
                            0.84,
                        child: TransactionList(
                            userTransactionList, _removeUserTransaction)),
              if (!isLandscape)
                Container(
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          appBarVar.preferredSize.height) *
                      0.3,
                  child: Chart(_recentTransaction),
                ),
              if (!isLandscape)
                Container(
                    height: (mediaQuery.size.height -
                            mediaQuery.padding.top -
                            appBarVar.preferredSize.height) *
                        0.7,
                    child: TransactionList(
                        userTransactionList, _removeUserTransaction)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {displayBottomUpModalSheet(context)},
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}
