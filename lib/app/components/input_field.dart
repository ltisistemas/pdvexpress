import 'package:flutter/material.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

class InputField extends StatelessWidget {
  final String labelText;
  TextInputType? type = TextInputType.text;
  bool? obscureText = false;
  Function(String)? onChanged;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  String? Function(String?)? validator;
  final String? initialValue;
  final bool? enabled;

  InputField({
    Key? key,
    required this.labelText,
    this.type,
    this.obscureText,
    this.onChanged,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.initialValue,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final enen = enabled ?? true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        validator: validator,
        initialValue: initialValue,
        onChanged: (t) => { onChanged },
        keyboardType: type,
        textInputAction: textInputAction,
        enabled: enabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: lightColor,
          ),
          fillColor: darkThemeInputs,
          filled: true,
        ),
      ),
    );
  }
}
