import 'package:flutter/material.dart';
import 'package:task/Utils/constants.dart';
import 'package:task/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool obscure;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
