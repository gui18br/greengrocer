import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isScret;
  final List<MaskTextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isScret = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isScret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isScret ? IconButton(onPressed: () {
              setState(() {
                              isObscure = !isObscure;
              });
            }, icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off)) : null,
            labelText: widget.label,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
