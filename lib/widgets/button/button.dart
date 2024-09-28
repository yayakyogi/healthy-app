import 'package:flutter/material.dart';
import 'package:healthy_app/theme.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    required this.label,
    required this.onClick,
    this.isPrimary = true,
    this.isDisabled = false,
    this.width = double.infinity,
  });

  final String label;
  final Function() onClick;
  final bool isPrimary;
  final bool isDisabled;
  final double width;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !widget.isDisabled ? widget.onClick : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: widget.isPrimary ? primaryColor : disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          widget.label,
          style: fontSemibold.copyWith(
            color: widget.isPrimary ? whiteColor : textSecondaryColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
