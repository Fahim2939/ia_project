import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ia_project/common/repository/common_supabase_storage_repository.dart';
import 'package:ia_project/common/utils/failure.dart';
import 'package:ia_project/common/utils/typedef.dart';
import 'package:ia_project/models/usermodel.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance,firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth _auth ;
  final FirebaseFirestore _firestore;

  AuthRepository({required FirebaseAuth auth,required FirebaseFirestore firestore}) : _auth = auth,_firestore = firestore;

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
  FutureVoid saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required Ref ref,
    // required BuildContext context
  }) async{
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl = 'https://static.vecteezy.com/system/resources/previews/024/983/914/non_2x/simple-user-default-icon-free-png.png';

        if (profilePic != null) {
          photoUrl = await ref.read(CommonSupabaseStorageRepositoryProvider).uploadFile(bucket: 'profilepic', path: 'user/$uid', file: profilePic);
        }
        var user = Usermodel(name: name, uid: uid, photoUrl: photoUrl, isOnline: true, phoneNumber: _auth.currentUser!.uid, groupId: []);

        _firestore.collection('users').doc(uid).set(user.toMap());
        return right(null);

    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e){
      return left(Failure(text: e.toString().trim()));
    }

  }


}