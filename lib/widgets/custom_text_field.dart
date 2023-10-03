import 'package:flutter/material.dart';

Widget customTextFormField(TextEditingController controller, String textLabel, String prefixedText, Function func) {
  return TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    onChanged: (value) => func(value),
    decoration: InputDecoration(
      labelText: textLabel,
      labelStyle: const TextStyle(color: Colors.white),
      border: const OutlineInputBorder(),
      prefixText: "$prefixedText ",
    ),
    style: const TextStyle(color: Colors.white, fontSize: 25.0),
  );
}
