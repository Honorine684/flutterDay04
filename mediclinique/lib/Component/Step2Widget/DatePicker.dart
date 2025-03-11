import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.onDateChanged});

  final void Function(DateTime date) onDateChanged; // Callback

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    ) ?? selectedDate;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateChanged(selectedDate); // Envoi de la date sélectionnée au parent
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Text("Date: $formattedDate", style: TextStyle(fontSize: 13)),
          IconButton(
            onPressed: () => selectDate(context),
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
    );
  }
}
