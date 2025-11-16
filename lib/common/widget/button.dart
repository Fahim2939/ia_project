// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ia_project/theme/colors.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Custombutton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.tabColor,
        minimumSize: Size(120, 50),
      ),
      child: Text(text, style: TextStyle(color: colors.blackColor)),
    );
  }
}
