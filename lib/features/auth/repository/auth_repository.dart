import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ia_project/common/utils/snackbar.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance));

class AuthRepository {
  final FirebaseAuth _auth ;
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  Future<void> signInWithPhone( BuildContext context,String number)async{
    try {
     await _auth.verifyPhoneNumber(phoneNumber: number,verificationCompleted: (PhoneAuthCredential credential)async{ await _auth.signInWithCredential(credential);}, verificationFailed: (error) {
      throw Exception(error.message);
     }, codeSent: ((String verificationId, int? resendToken)async{
      context.push('/otp', extra: verificationId);

     }), codeAutoRetrievalTimeout: (String verificationId){});

    } on FirebaseAuthException catch (error) {
      snackbar(context, error.message!);

    }
  }
  Future<void> verifyOtp({
    required String verificationId,
    required BuildContext context,
    required String userOtp
  })async{
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
      await _auth.signInWithCredential(credential);
      context.replace('/userInformationScreen');

    } on FirebaseAuthException catch (error) {
      snackbar(context, error.message!);
    }
  }


}