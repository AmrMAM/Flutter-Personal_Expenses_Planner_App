// import 'dart:html';

import 'package:flutter/material.dart';
import '../widgets/pick_date.dart';

class NewTransaction extends StatefulWidget {
  final void Function(
      {required String title,
      required double amount,
      required DateTime date}) addTx;

  NewTransaction(this.addTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _dateController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 800),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (val) {
                  _amountController.text = val;
                },
              ),
              SizedBox(
                height: 4,
              ),
              DatePicker(
                datePickerController: _dateController,
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                child: Text('Add Transaction'),
                onPressed: () {
                  try {
                    if (double.parse(_amountController.text) >= 0.0 &&
                        _titleController.text.isNotEmpty &&
                        _dateController.pickedDate != null) {
                      widget.addTx(
                        amount: double.parse(_amountController.text),
                        title: _titleController.text,
                        date: _dateController.pickedDate!,
                      );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added Successfully')));
                      return;
                    } else {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Fill all Data First')));
                      return;
                    }
                  } catch (e) {
                    print(e);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fill all Data First')));
                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
