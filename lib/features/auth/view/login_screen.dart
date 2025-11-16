import 'package:flutter/material.dart';
import 'package:ia_project/common/widget/error_widget.dart';
import 'package:ia_project/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter your Number'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'whatsApp will need to verify your phone number',
              style: TextStyle(fontSize: 12),
            ),
            TextButton(onPressed: () {}, child: Text('Pick country')),
          ],
        ),
      ),
    );
  }
}
