import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController textController;

  const TextInputField({
    super.key,
    required this.label,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  void clearTextField() {
    textController.clear();
  }
}
