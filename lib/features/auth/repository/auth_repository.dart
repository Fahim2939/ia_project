import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:ia_project/common/utils/failure.dart';
import 'package:ia_project/common/utils/snackbar.dart';
import 'package:ia_project/common/utils/typedef.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance));

class AuthRepository {
  final FirebaseAuth _auth ;
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  FutureEither<String> signInWithPhone(String number)async{
    final completer = Completer<Either<Failure , String>>();
    try {
     await _auth.verifyPhoneNumber(phoneNumber: number,verificationCompleted: (PhoneAuthCredential credential)async{ await _auth.signInWithCredential(credential);}, verificationFailed: (error) {
      completer.complete(left(Failure(text: error.message!.trim())));
     }, codeSent: ((String verificationId, int? resendToken){
      // context.push('/otp', extra: verificationId);
      completer.complete(right(verificationId));

     }), codeAutoRetrievalTimeout: (String verificationId){});

    } on FirebaseAuthException catch (error) {
      throw error.message!.trim();
    }catch(e){
      completer.complete(left(Failure(text: e.toString().trim())));
    }
    return completer.future;
  }
  FutureVoid verifyOtp({
    required String verificationId,
    required BuildContext context,
    required String userOtp
  })async{
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
      await _auth.signInWithCredential(credential);
      return right(null);

    } on FirebaseAuthException catch (error) {
      throw error.message!.trim();
    }catch (e) {
      return left(Failure(text: e.toString().trim()));
    }
  }


}