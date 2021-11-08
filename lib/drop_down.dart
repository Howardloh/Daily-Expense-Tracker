import 'package:flutter/material.dart';

// ignore: use_function_type_syntax_for_parameters
Widget customDropDown(List<String> items, String value, void onChange(val)) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (val) {
        onChange(val);
      },
      items: items.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem(
          child: Text(val),
          value: val,
        );
      }).toList(),
    ),
  );
}
