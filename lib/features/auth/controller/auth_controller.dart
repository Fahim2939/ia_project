import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ia_project/common/utils/snackbar.dart';
import 'package:ia_project/features/auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
    : _authRepository = authRepository, super(false);

  Future<void> signInWithNumber(BuildContext context, String number) async {
    state = true;
    final controller = await _authRepository.signInWithPhone(number);
    state = false;
    controller.match((l) {snackbar(context, l.text);}, (r){
      context.push('/otp' ,extra: r);
    });

  }
  Future<void> verifyOtp(BuildContext context, String verificationId, String  userOtp ) async {
    state = true;
    final controller = await _authRepository.verifyOtp(verificationId: verificationId, context: context, userOtp: userOtp);
    state = false;
    controller.fold((l) => snackbar(context, l.text), (r) => context.replace('/userInformationScreen'));

  }
}
