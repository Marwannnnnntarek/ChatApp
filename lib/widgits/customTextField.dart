import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextInputType inputType;
  final bool isObscure;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.inputType = TextInputType.text,
    this.isObscure = false,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
      ),
      keyboardType: inputType,
      obscureText: isObscure,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
