import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
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
   await _authRepository.signInWithPhone(context, number);
    state = false;
  }
  Future<void> verifyOtp(BuildContext context, String verificationId, String  userOtp ) async {
    state = true;
    await _authRepository.verifyOtp(verificationId: verificationId, context: context, userOtp: userOtp);
    state = false;
  }
}
