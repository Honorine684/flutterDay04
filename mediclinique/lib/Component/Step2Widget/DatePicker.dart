import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState(){
    return DatePickerState();
  }
}

class DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  
  bool showDate = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900), // Date de début
      lastDate: DateTime(2101), // Date de fin
    ) ?? selectedDate;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        showDate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formater la date au format "dd/MM/yyyy"
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    return 
        Container(
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
          child:Row(
        children: [
          !showDate
              ? Text(
                  "Votre date de naissance",
                  style: TextStyle(fontSize: 14),
                )
              : Text(
                  "Date: $formattedDate",
                  style: TextStyle(fontSize: 13),
                ),
          IconButton(
            onPressed: () => selectDate(context),
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
        );
      
    
  }
}
