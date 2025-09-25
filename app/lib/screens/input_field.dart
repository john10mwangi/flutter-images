import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.textInputType = TextInputType.text,
    required this.autofillHints,
    this.value,
    required this.onChanged,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.trailing,
  });

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<String> autofillHints;
  final String? value;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final Widget? trailing;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          // color: const Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: const Color(0xFFF1F1FA), width: 1),
        ),
        child: TextFormField(
          // controller: TextEditingController(text: value),
          controller: controller,
          onChanged: onChanged,
          keyboardType: textInputType,
          obscureText: obscureText,
          autofillHints: autofillHints,
          validator: validator,
          // style: inputTextStyle,
          decoration: InputDecoration(
            label: label.isNotEmpty ? Text(label) : null,
            // labelStyle: labelTextStyle,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            hintText: hintText,
            // hintStyle: hintTextStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            suffixIcon: trailing != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: trailing,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 40,
            ),
          ),
        ),
      ),
    );
  }
}
