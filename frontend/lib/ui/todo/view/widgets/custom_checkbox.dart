import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    this.isChecked = false,
    required this.onChanged,
  });

  final bool isChecked;

  final dynamic Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(isChecked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.pink.shade400,
            width: 4,
          ),
          color: isChecked ? Colors.pink.shade400 : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isChecked
            ? const Icon(
                Icons.done,
                color: Colors.black,
              )
            : const Icon(
                Icons.done,
                color: Colors.transparent,
              ),
      ),
    );
  }
}
