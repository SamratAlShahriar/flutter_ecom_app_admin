import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

const String userCollection = 'Users';
const String userFieldUserId = 'user_id';
const String userFieldUserDisplayName = 'user_display_name';
const String userFieldUserAddress = 'user_address';
const String userFieldUserCreationTime = 'user_creation_time';
const String userFieldUserImageUrl = 'user_image_url';
const String userFieldUserGender = 'user_gender';
const String userFieldUserAge = 'user_age';
const String userFieldUserPhone = 'user_phone';
const String userFieldUserEmail = 'user_email';

class UserModel {
  String? userId;
  String? displayName;
  AddressModel? addressModel;
  Timestamp? userCreationTIme;
  String? userImageUrl;
  String? gender;
  num? age;
  String? phone;
  String email;

  UserModel({
    this.userId,
    this.displayName,
    this.addressModel,
    this.userCreationTIme,
    this.userImageUrl,
    this.gender,
    this.age,
    this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldUserId: userId,
      userFieldUserDisplayName: displayName,
      userFieldUserAddress: addressModel?.toMap(),
      userFieldUserCreationTime: userCreationTIme,
      userFieldUserImageUrl: userImageUrl,
      userFieldUserGender: gender,
      userFieldUserAge: age,
      userFieldUserPhone: phone,
      userFieldUserEmail: email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map[userFieldUserId],
      displayName: map[userFieldUserDisplayName],
      addressModel: map[userFieldUserAddress] == null
          ? null
          : AddressModel.fromMap(map[userFieldUserAddress]),
      userCreationTIme: map[userFieldUserCreationTime],
      userImageUrl: map[userFieldUserImageUrl],
      gender: map[userFieldUserGender],
      age: map[userFieldUserAge],
      phone: map[userFieldUserPhone],
      email: map[userFieldUserEmail],
    );
  }
}
