// import 'dart:html';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final void Function(String id) deleteTx;

  const TransactionTile(
      {Key? key, required this.transaction, required this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Text(
            '\$${transaction.amount}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          '${transaction.name}',
          style:
              Theme.of(context).textTheme.subtitle1, //TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          '${DateFormat('dd-MM-yyyy hh:mm').format(transaction.date)}',
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () => deleteTx(transaction.id)),
      ),
    );
  }
}
