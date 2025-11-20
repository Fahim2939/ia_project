import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ia_project/common/utils/snackbar.dart';
import 'package:ia_project/features/auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository,ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository,required Ref ref})
    : _authRepository = authRepository,_ref = ref,
      super(false);

  Future<void> signInWithNumber(BuildContext context, String number) async {
    state = true;
    final controller = await _authRepository.signInWithPhone(number);
    state = false;
    controller.match(
      (l) {
        snackbar(context, l.text);
      },
      (r) {
        context.push('/otp', extra: r);
      },
    );
  }

  Future<void> verifyOtp(
    BuildContext context,
    String verificationId,
    String userOtp,
  ) async {
    state = true;
    final controller = await _authRepository.verifyOtp(
      verificationId: verificationId,
      context: context,
      userOtp: userOtp,
    );
    state = false;
    controller.fold(
      (l) => snackbar(context, l.text),
      (r) => context.replace('/userInformationScreen'),
    );
  }

  Future<void> saveUserDataToFirebase(
    String name,
    File? profilePic,
    BuildContext context,
  ) async {
    state =true;
    final controller = await _authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: _ref,
    );
    state = false;
    controller.fold((l)=> snackbar(context, l.text), (r)=> snackbar(context,'upload completed'));
  }
}
