// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Usermodel {
  final String name;
  final String uid;
  final String photoUrl;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;
  Usermodel({
    required this.name,
    required this.uid,
    required this.photoUrl,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Usermodel copyWith({
    String? name,
    String? uid,
    String? photoUrl,
    bool? isOnline,
    String? phoneNumber,
    List<String>? groupId,
  }) {
    return Usermodel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
      isOnline: map['isOnline'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      groupId: List<String>.from((map['groupId'] as List<String>),
    )
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) => Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usermodel(name: $name, uid: $uid, photoUrl: $photoUrl, isOnline: $isOnline, phoneNumber: $phoneNumber, groupId: $groupId)';
  }

  @override
  bool operator ==(covariant Usermodel other) {
    if (identical(this, other)) return true;

    return
      other.name == name &&
      other.uid == uid &&
      other.photoUrl == photoUrl &&
      other.isOnline == isOnline &&
      other.phoneNumber == phoneNumber &&
      listEquals(other.groupId, groupId);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      uid.hashCode ^
      photoUrl.hashCode ^
      isOnline.hashCode ^
      phoneNumber.hashCode ^
      groupId.hashCode;
  }
}
