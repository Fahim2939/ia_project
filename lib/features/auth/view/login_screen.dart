import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ia_project/common/utils/progressbar.dart';
import 'package:ia_project/common/utils/snackbar.dart';
import 'package:ia_project/common/widget/button.dart';
import 'package:ia_project/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country? selectedCountryCode; // default Bangladesh
  String selectedCountryFlag = "🇧🇩"; // optional

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true, // shows +91, +880 etc.
      onSelect: (Country country) {
        setState(() {
          selectedCountryCode = country;
          // selectedCountryFlag = country.flagEmoji;
        });
      },
    );
  }

  void sendPhoneNumber() {
    final number = phoneController.text.trim();
    if (number.isNotEmpty && selectedCountryCode != null) {
      ref.read(authControllerProvider.notifier).signInWithNumber(context, '+${selectedCountryCode!.phoneCode} $number');
    }else{
      snackbar(context, 'error');
    }
  }

  @override
  Widget build(BuildContext context,) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Enter your Number'), elevation: 0),
      body: isLoading ? Progressbar() : SingleChildScrollView(
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
              TextButton(onPressed: pickCountry, child: Text('Pick country')),
              SizedBox(height: 20),
              Row(
                children: [
                  if (selectedCountryCode != null)
                    Text(
                      '+${selectedCountryCode!.phoneCode}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
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
              Custombutton(text: 'Next', onPressed: () {
                sendPhoneNumber();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
