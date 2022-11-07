import 'date_model.dart';

const String collectionPurchase = 'Purchase';
const String purchaseFieldPurId = 'purchase_id';
const String purchaseFieldProId = 'product_id';
const String purchaseFieldPurQuantity = 'purchase_quantity';
const String purchaseFieldPurPrice = 'purchase_price';
const String purchaseFieldDate = 'purchase_date';

class PurchaseModel {
  String? purchaseId;
  String? productId;
  num purchaseQuantity;
  num purchasePrice;
  DateModel dateModel;

  PurchaseModel({
    this.purchaseId,
    this.productId,
    required this.purchaseQuantity,
    required this.purchasePrice,
    required this.dateModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      purchaseFieldPurId: purchaseId,
      purchaseFieldProId: productId,
      purchaseFieldPurQuantity: purchaseQuantity,
      purchaseFieldPurPrice: purchasePrice,
      purchaseFieldDate: dateModel.toMap(),
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      purchaseQuantity: map[purchaseFieldPurQuantity],
      purchasePrice: map[purchaseFieldPurPrice],
      dateModel: DateModel.fromMap(map[purchaseFieldDate]),
    );
  }
}
