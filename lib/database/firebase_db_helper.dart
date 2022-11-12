import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';
import 'package:flutter_ecom_app_admin/models/product_model.dart';
import 'package:flutter_ecom_app_admin/models/purchase_model.dart';

import '../models/order_constatnt_model.dart';

class FirebaseDbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection('Admins').doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel) {
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.categoryId = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    final categoryDoc = _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId);
    productModel.productId = productDoc.id;
    purchaseModel.productId = productDoc.id;
    purchaseModel.purchaseId = purchaseDoc.id;
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    wb.update(categoryDoc, {
      categoryFieldProductCount:
          (productModel.category.productCount + purchaseModel.purchaseQuantity),
    });

    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionUtils).doc(documentOrderConstant).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
          CategoryModel categoryModel) =>
      _db
          .collection(collectionProduct)
          .where('$productFieldCategory.$categoryFieldId',
              isEqualTo: categoryModel.categoryId)
          .snapshots();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPurchaseByPurchaseId(
      String productId) =>
      _db
          .collection(collectionPurchase)
          .where(purchaseFieldProId,
          isEqualTo: productId)
          .get();

  static Future<void> deleteImage(String downloadUrl) {
    return FirebaseStorage.instance.refFromURL(downloadUrl).delete();
  }

  static Future<void> updateProductField(String productId, Map<String, dynamic> map){
    return _db.collection(collectionProduct)
        .doc(productId)
        .update(map);
  }

  static Future<void> repurchase (
      PurchaseModel purchaseModel, ProductModel productModel) async{
    final wb = _db.batch();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    purchaseModel.purchaseId = purchaseDoc.id;
    wb.set(purchaseDoc, purchaseModel.toMap());
    final productDoc =
        _db.collection(collectionProduct).doc(productModel.productId);
    wb.update(productDoc, {
      productFieldStock: (productModel.stock + purchaseModel.purchaseQuantity)
    });
    final snapshot = await _db.collection(collectionCategory)
    .doc(productModel.category.categoryId).get();
    final prevCount = snapshot.data()![categoryFieldProductCount];
    final categoryDoc = _db.collection(collectionCategory).doc(productModel.category.categoryId);
    wb.update(categoryDoc, {
      categoryFieldProductCount:(prevCount + purchaseModel.purchaseQuantity),
    });
    return wb.commit();
  }

  static Future<void> updateOrderConstants(OrderConstantModel model) {
    return _db.collection(collectionUtils)
        .doc(documentOrderConstant)
        .update(model.toMap());
  }
}
