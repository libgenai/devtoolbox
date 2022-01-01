import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final ValueChanged<T?> onChanged;

  const CustomRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _customRadioButton,
            const SizedBox(width: 2),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Icon(
      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
      size: 16,
    );
  }
}
