import 'package:flutter/material.dart';

class TextInputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textController;

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
      ),
    );
  }
}
