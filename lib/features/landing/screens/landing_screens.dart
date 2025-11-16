import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ia_project/common/widget/button.dart';
import 'package:ia_project/theme/colors.dart';

class LandingScreens extends StatelessWidget {
  const LandingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Wellcome to WhatsApp',
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height / 10),
              Image.asset(
                'assets/images/bg.png',
                width: 340,
                height: 340,
                color: colors.tabColor,
              ),
              SizedBox(height: size.height / 10),
              Text(
                'Read our privacy policy. Tap "Agree and continue" to accept the terms of serivice',
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.greyColor),
              ),
              SizedBox(height: 20),
              Custombutton(
                text: 'Agree and Continue',
                onPressed: () {
                  context.push('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
