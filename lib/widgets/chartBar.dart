import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double dayAmount;
  final double maxPercentageSpending;
  ChartBar(this.weekDay, this.dayAmount, this.maxPercentageSpending);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
            child: FittedBox(
              child: Text("\₹ ${dayAmount.toString()}"),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.02,
          ),
          Container(
            height: constraints.maxHeight * 0.65,
            width: 15,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                maxPercentageSpending == 0
                    ? Container()
                    : FractionallySizedBox(
                        heightFactor: maxPercentageSpending,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.02,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: Text(weekDay),
          ),
        ],
      ),
    );
  }
}
