import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final String lable;
  final double percentageOfTotal;

  ChartBar(
      {required this.lable,
      required this.amount,
      required this.percentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(child: Text('\$${amount.toStringAsFixed(1)}')),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 90,
          width: 12,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey),
              ),
              FractionallySizedBox(
                heightFactor: percentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(lable),
      ],
    );
  }
}
