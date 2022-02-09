import 'package:flutter/material.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  final String labelText;
  Function(String)? onChanged;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  String? Function(String?)? validator;

  PasswordField({
    Key? key,
    required this.labelText,
    this.onChanged,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: _isObscure,
        onChanged: (t) => { widget.onChanged },
        keyboardType: TextInputType.text,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: lightColor,
          ),
          fillColor: darkThemeInputs,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: darkThemeSecondary),
            onPressed: () {
              setState(() => _isObscure = !_isObscure);
            },
          ),
        ),
      ),
    );
  }
}
