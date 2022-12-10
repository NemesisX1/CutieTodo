import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.controller,
    this.validator,
    this.onTap,
    this.obscureText = false,
    this.suffix,
    this.suffixIcon,
    this.readonly = false,
  });

  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool obscureText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        const Gap(10),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          cursorColor: Colors.white,
          validator: validator,
          onTap: onTap,
          readOnly: readonly,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            suffix: suffix,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.pinkAccent.shade400,
                width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.pinkAccent.shade400,
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
