import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

class UserModel{
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
}