import 'package:flutter/material.dart';

class TextInputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textController;

  bool isDateField() {
    // Add your logic here to determine if it's a date field
    return label.toLowerCase().contains('date');
  }

  const TextInputFieldWidget({
    super.key,
    required this.label,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        hintText: isDateField() ? 'YYYY-MM-DD' : null,
      ),
    );
  }
}
