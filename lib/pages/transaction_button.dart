import 'package:flutter/material.dart';

class TransactionActionButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const TransactionActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<TransactionActionButton> createState() =>
      _TransactionActionButtonState();
}

class _TransactionActionButtonState extends State<TransactionActionButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(widget.buttonText),
    );
  }
}
