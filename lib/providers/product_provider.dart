import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/database/firebase_db_helper.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';

class ProductProvider extends ChangeNotifier{
  Future<void> addNewCategory(String category) {
    final categoryModel = CategoryModel(categoryName: category);
    return FirebaseDbHelper.addCategory(categoryModel);
  }
}