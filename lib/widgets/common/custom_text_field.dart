import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final int maxLines;

  // AJOUT POUR LA VALIDATION
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      obscureText: widget.obscureText ? _isHidden : false,

      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: const OutlineInputBorder(),

        prefixIcon: Visibility(
          visible: widget.prefixIcon != null,
          child: Icon(widget.prefixIcon),
        ),

        suffixIcon: Visibility(
          visible: widget.obscureText,
          child: IconButton(
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
          ),
        ),
      ),
    );
  }
}