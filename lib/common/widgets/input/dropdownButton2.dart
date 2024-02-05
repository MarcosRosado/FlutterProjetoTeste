import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../../modules/authentication/widgets/internal_widgets.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {super.key,
      required this.title,
      required this.onChanged,
      required this.dropdownValue,
      required this.options,
      this.placeholder = "Selecione um Item",
      this.dropdownWidth = double.infinity,
      this.dropdownHeight = 200});
  final String title;
  final void Function(String?) onChanged;
  final String? dropdownValue;
  final List<String> options;
  final double? dropdownHeight;
  final double? dropdownWidth;
  final String placeholder;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    var mappedItems = widget.options
        .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 12)),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: widget.dropdownValue,
            isExpanded: true,
            hint: Text(
              widget.placeholder,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            items: mappedItems,
            onChanged: widget.onChanged,
            buttonStyleData: ButtonStyleData(
              width: widget.dropdownWidth,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue, // Outline color
                  width: 2, // Outline thickness
                ),
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.expand_more,
              ),
              iconSize: 34,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: widget.dropdownHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              offset: const Offset( 0, -5),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                crossAxisMargin: 12,
                mainAxisMargin: 8,
                thickness: MaterialStateProperty.all(12),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}
