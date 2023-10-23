import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final Function(String, int) onPressed;

  SettingsButton({
    required this.color,
    required this.text,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        onPressed(this.text,
            this.value); // Pass the text and value to the onPressed function
      },
      color: this.color,
    );
  }
}
