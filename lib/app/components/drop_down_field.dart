import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final String labelText;
  List<Map<String, dynamic>> items = [];
  String? selected;
  final Function(String?)? onChanged;

  DropDownField({
    Key? key,
    required this.labelText,
    required this.items,
    this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selected ?? items.first['value'].toString(),
        isExpanded: true,
        items: items
            .map(
              (item) => DropdownMenuItem(
                child: Text(
                  item['text'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                value: item['value'].toString(),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            labelText: labelText),
      ),
    );
  }
}
