import 'package:flutter_ecom_app_admin/models/category_model.dart';

const String collectionProduct = 'Products';
const String productFieldId = 'product_id';
const String productFieldName = 'product_name';
const String productFieldCategory = 'product_category';
const String productFieldShortDescription = 'product_short_description';
const String productFieldLongDescription = 'product_long_description';
const String productFieldSalePrice = 'product_sale_price';
const String productFieldStock = 'product_stock';
const String productFieldDiscount = 'product_discount';
const String productFieldThumbnail = 'product_thumbnail';
const String productFieldImages = 'product_images';
const String productFieldAvailable = 'product_available';
const String productFieldFeatured = 'product_featured';

class ProductModel {
  String? productId;
  String productName;
  CategoryModel category;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num productDiscount;
  String thumbnailImageUrl;
  List<String>? additionalImages;
  bool available;
  bool featured;

  ProductModel(
      {this.productId,
        required this.productName,
        required this.category,
        this.shortDescription,
        this.longDescription,
        required this.salePrice,
        required this.stock,
        this.productDiscount = 0,
        required this.thumbnailImageUrl,
        this.additionalImages,
        this.available = true,
        this.featured = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category.toMap(),
      productFieldShortDescription: shortDescription,
      productFieldLongDescription: longDescription,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldDiscount: productDiscount,
      productFieldThumbnail: thumbnailImageUrl,
      productFieldImages: additionalImages,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map[productFieldId],
      productName: map[productFieldName],
      category: CategoryModel.fromMap(map[productFieldCategory]),
      shortDescription: map[productFieldShortDescription],
      longDescription: map[productFieldLongDescription],
      salePrice: map[productFieldSalePrice],
      stock: map[productFieldStock],
      thumbnailImageUrl: map[productFieldThumbnail],
      additionalImages: map[productFieldImages] != null
          ? map[productFieldImages] as List<String>
          : null,
      available: map[productFieldAvailable],
      featured: map[productFieldFeatured],
    );
  }
}
