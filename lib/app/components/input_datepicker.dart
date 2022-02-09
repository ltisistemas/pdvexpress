import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class InputDatepicker extends StatefulWidget {
  final String labelText;
  bool? obscureText = false;
  Function(String)? onChanged;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  String? Function(String?)? validator;
  final String? initialValue;
  final bool? enabled;
  String? selectedDate;
  final Function(String) onChangedData;

  InputDatepicker({
    Key? key,
    required this.labelText,
    this.obscureText,
    this.onChanged,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.selectedDate,
    required this.onChangedData,
  }) : super(key: key);

  @override
  State<InputDatepicker> createState() => _InputDatepickerState();
}

class _InputDatepickerState extends State<InputDatepicker> {
  Future<void> showPicker() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
      locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      setState(() {
        final transform = DateFormat('dd/MM/yyyy').format(picked);
        widget.controller.text = transform;

        widget.selectedDate = DateFormat('yyyy-MM-dd').format(picked);
        widget.onChangedData(DateFormat('yyyy-MM-dd').format(picked));
        print(widget.selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText ?? false,
        validator: widget.validator,
        initialValue: widget.initialValue,
        keyboardType: TextInputType.datetime,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          labelText: widget.labelText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () => showPicker(),
          ),
        ),
      ),
    );
  }
}
