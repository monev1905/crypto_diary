import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final TextEditingController textController;

  const TextInputField({
    super.key,
    required this.label,
    required this.textController,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();

  void clearTextField() {
    textController.clear();
  }
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextFormField(
        controller: widget.textController,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
      ),
    );
  }
}
