import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_app/theme.dart';

class TextfieldWidget extends StatefulWidget {
  const TextfieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.textInputFormatter,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final List<TextInputFormatter> textInputFormatter;

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: textSecondaryColor)),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: TextInputType.number,
          inputFormatters: widget.textInputFormatter,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: borderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: dangerColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: dangerColor),
            ),
          ),
        ),
      ],
    );
  }
}
