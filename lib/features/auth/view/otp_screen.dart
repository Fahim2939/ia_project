// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ia_project/common/utils/progressbar.dart';
import 'package:ia_project/features/auth/controller/auth_controller.dart';
import 'package:ia_project/theme/colors.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }
  void verifyOtp(){
    ref.read(authControllerProvider.notifier).verifyOtp(context, widget.verificationId, _pinController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 26, color: Colors.white),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red, width: 2),
      ),
    );
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        title: Text('Verify your number'),
      ),
      body:isLoading ? Progressbar() :Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'We have sent an SMS with a code',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 20),
            Center(
              child: Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                controller: _pinController,
                focusNode: _pinFocusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                errorPinTheme: errorPinTheme,
                showCursor: true,
                onCompleted: (value) {
                  verifyOtp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
