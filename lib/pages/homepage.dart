import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as spr;
import '../widgets/transaction.dart';
import '../widgets/new_transaction.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';

class _VarStates {
  static List<Transaction> transactions = [];
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = _VarStates.transactions;
  List<Transaction> _recentTransactions() {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _setListData() {
    spr.SharedPreferences.getInstance().then((value) {
      final String _data = (value.get('dataList') as String?) ?? '[]';
      final List _lstMap = jsonDecode(_data == '' ? '[]' : _data);
      setState(() {
        _VarStates.transactions = _lstMap.map<Transaction>((a) {
          var e = jsonDecode(a as String) as Map<num, Object?>;
          return Transaction(
              amount: e['c'] as double,
              id: e['a'] as String,
              date: e['d'] as DateTime,
              name: e['b'] as String);
        }).toList();
      });
    });
  }

  void _addTx({
    required String title,
    required double amount,
    required DateTime date,
  }) {
    _transactions.add(
      Transaction(
        amount: amount,
        id: DateTime.now().millisecond.toString(),
        date: date,
        name: title,
      ),
    );
    // print(jsonEncode(
    //     {0: 'dfsdfsdf', 55: 'sdfsdfsdf', 'dsfdf': 'ddd', 02: 22222}));
    // spr.SharedPreferences.getInstance().then(
    //   (value) => value.setString(
    //     'dataList',
    //     jsonEncode(
    //       _transactions,
    //     ),
    //   ),
    // );
    // Chart.stateD(() {});
    setState(() {});
  }

  void _deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showBottomModal(ctx) {
    // print(spr.SharedPreferences.getInstance().then((value) {
    //   print(value.getString('dataList'));
    // }));
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) {
        return NewTransaction(_addTx);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // _setListData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomModal(context),
        tooltip: 'Add a Transaction',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Chart(_recentTransactions),
                  Container(
                    height: 450,
                    child: _transactions.length > 0
                        ? ListView.builder(
                            itemCount: _transactions.length,
                            itemBuilder: (ctx, index) {
                              return TransactionTile(
                                transaction: _transactions[index],
                                deleteTx: _deleteTx,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
