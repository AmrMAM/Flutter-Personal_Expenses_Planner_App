import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.datePickerController,
    this.notPicked,
    this.picked,
    this.pick,
    this.firstDate,
    this.initialDate,
    this.lastDate,
  }) : super(key: key);
  final DatePickerController datePickerController;
  final Widget? notPicked;
  final Widget? picked;
  final Widget? pick;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void _showDialoge(DatePickerController controller) {
    showDatePicker(
      context: context,
      initialDate: _initD,
      firstDate: _fristD,
      lastDate: _lastD,
    ).then((value) => controller.pickedDate = value);
  }

  DateTime get _initD {
    return widget.initialDate ?? DateTime.now();
  }

  DateTime get _fristD {
    return widget.firstDate ?? DateTime.now().subtract(Duration(days: 1000));
  }

  DateTime get _lastD {
    return widget.lastDate ?? DateTime.now();
  }

  Widget get _picked {
    return widget.picked ??
        Text(
          'Picked Date: ${DateFormat.yMMMd().format(widget.datePickerController.pickedDate!)}',
        );
  }

  Widget get _notPicked {
    return widget.notPicked ?? Text('No Date Chosen!');
  }

  Widget get _pick {
    return widget.pick ?? Text('Choose Date');
  }

  @override
  Widget build(BuildContext context) {
    final _pickerController = widget.datePickerController;
    _pickerController._stateD = setState;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pickerController.pickedDate != null ? _picked : _notPicked,
          TextButton(
            child: _pick,
            onPressed: () => _showDialoge(_pickerController),
          ),
        ],
      ),
    );
  }
}

class DatePickerController {
  void Function(void Function())? _callSetState;
  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;
  set pickedDate(DateTime? val) => _callSetState!(() => _pickedDate = val);
  set _stateD(void Function(void Function()) val) => _callSetState = val;
}
