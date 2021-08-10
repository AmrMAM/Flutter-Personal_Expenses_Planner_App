import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> Function() recentTxs;
  static void Function(void Function()) stateD = (_void) => null;
  Chart(this.recentTxs);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Transaction> _recentTxs = [];

  double get _totalSpending {
    return _recentTxs.fold<double>(0.0, (val, element) => val + element.amount);
  }

  List<Widget> get _groupedCharBars {
    var _recentTotAmount = _totalSpending;
    if (_recentTotAmount == 0.0) {
      // return [];
      _recentTotAmount = 1;
    }
    var _daysData = List.generate(7, (index) {
      final _weekDay = DateTime.now().subtract(Duration(days: index));
      var _totSum = 0.0;
      for (var i = 0; i < _recentTxs.length; i++) {
        final _tx = _recentTxs[i];
        if (_tx.date.day == _weekDay.day &&
            _tx.date.month == _weekDay.month &&
            _tx.date.year == _weekDay.year) {
          _totSum += _tx.amount;
        }
      }

      return {
        'amount': _totSum,
        'lable': DateFormat.E().format(_weekDay),
        'pct': _totSum / _recentTotAmount,
      };
    });
    return _daysData
        .map(
          (e) => Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                lable: e['lable'] as String,
                amount: e['amount'] as double,
                percentageOfTotal: e['pct'] as double),
          ),
        )
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Chart.stateD = setState;
    _recentTxs = widget.recentTxs();
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedCharBars,
        ),
      ),
    );
  }
}
