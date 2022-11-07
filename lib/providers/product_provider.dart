import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/database/firebase_db_helper.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';
import 'package:flutter_ecom_app_admin/models/product_model.dart';
import 'package:flutter_ecom_app_admin/models/purchase_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addNewCategory(String category) {
    final categoryModel = CategoryModel(categoryName: category);
    return FirebaseDbHelper.addCategory(categoryModel);
  }

  void getAllCategories() {
    FirebaseDbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList
          .sort((cat1, cat2) => cat1.categoryName.compareTo(cat2.categoryName));
      notifyListeners();
    });
  }

  Future<String> uploadImage(String thumbnailImagePath) async{
    final imageRef = FirebaseStorage.instance
        .ref('Product_Images')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    final uploadTask = imageRef.putFile(File(thumbnailImagePath));
    // uploadTask.asStream().listen((event) {
    //   event.bytesTransferred;
    //   event.totalBytes;
    // });
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    return FirebaseDbHelper.addNewProduct(productModel,purchaseModel);
  }
}
