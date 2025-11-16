import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/common/widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = ''; // default Bangladesh
  String selectedCountryFlag = "🇧🇩"; // optional

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Enter your Number'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'whatsApp will need to verify your phone number',
                style: TextStyle(fontSize: 12),
              ),
              TextButton(
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true, // shows +91, +880 etc.
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountryCode = "+${country.phoneCode}";
                        selectedCountryFlag = country.flagEmoji;
                      });
                    },
                  );
                },
                child: Text('Pick country'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(selectedCountryCode),
                  SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hint: Text('enter phone number'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.6),
              Custombutton(text: 'Next', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
