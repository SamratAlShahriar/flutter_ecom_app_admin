import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';

class FirebaseDbHelper{
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection('Admin').doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel){
    final doc = _db.collection(COLLECTION_CATEGORY).doc();
    categoryModel.categoryId = doc.id;
    return doc.set(categoryModel.toMap());
  }
}