const String collectionOrderConstant = 'Order_Constant';
const String orderConstantFieldDiscount = 'oc_discount';
const String orderConstantFieldVat = 'oc_vat';
const String orderConstantFieldDeliveryCharge = 'oc_delivery_charge';

class OrderConstantModel {
  num discount;
  num vat;
  num deliveryCharge;

  OrderConstantModel({
    this.discount = 0,
    this.vat = 0,
    this.deliveryCharge = 0,
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      orderConstantFieldDiscount:discount,
      orderConstantFieldVat:vat,
      orderConstantFieldDeliveryCharge:deliveryCharge,
    };
  }

  factory OrderConstantModel.fromMap(Map<String, dynamic> map){
    return OrderConstantModel(
      discount: map[orderConstantFieldDiscount],
      vat: map[orderConstantFieldVat],
      deliveryCharge: map[orderConstantFieldDeliveryCharge],
    );
  }
}
