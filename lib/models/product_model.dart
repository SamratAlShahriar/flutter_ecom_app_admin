import 'package:flutter_ecom_app_admin/models/category_model.dart';
import 'package:flutter_ecom_app_admin/models/product_description_model.dart';


const String collectionProduct = 'Products';
const String productFieldId = 'product_id';
const String productFieldName = 'product_name';
const String productFieldCategory = 'product_category';
const String productFieldDescription = 'product_descriptions';
const String productFieldShortDescription = 'product_short_description';
const String productFieldLongDescription = 'product_long_description';
const String productFieldSalePrice = 'product_sale_price';
const String productFieldStock = 'product_stock';
const String productFieldAvgRating = 'product_avg_rating';
const String productFieldDiscount = 'product_discount';
const String productFieldThumbnail = 'product_thumbnail';
const String productFieldImages = 'product_images';
const String productFieldTags = 'product_tags';
const String productFieldAvailable = 'product_available';
const String productFieldFeatured = 'product_featured';

class ProductModel {
  String? productId;
  String productName;
  CategoryModel category;
  List<ProductDescriptionModel>? descriptions;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num avgRating;
  num productDiscount;
  String thumbnailImageUrl;
  List<String> additionalImages;
  List<String> tags;
  bool available;
  bool featured;

  ProductModel(
      {this.productId,
        required this.productName,
        required this.category,
        this.descriptions,
        this.shortDescription,
        this.longDescription,
        required this.salePrice,
        required this.stock,
        this.avgRating = 0.0,
        this.productDiscount = 0,
        required this.thumbnailImageUrl,
        this.additionalImages = const <String>[],
        this.tags = const <String>[],
        this.available = true,
        this.featured = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category.toMap(),
      productFieldDescription: descriptions?.map((e) => e.toMap()).toList(),
      productFieldShortDescription: shortDescription,
      productFieldLongDescription: longDescription,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldAvgRating: avgRating,
      productFieldDiscount: productDiscount,
      productFieldThumbnail: thumbnailImageUrl,
      productFieldImages: additionalImages,
      productFieldTags: tags,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map[productFieldId],
      productName: map[productFieldName],

      category: CategoryModel.fromMap(map[productFieldCategory]),
      descriptions: map[productFieldDescription] == null
          ? null
          : (map[productFieldDescription] as List)
          .map((e) => ProductDescriptionModel.fromMap(e))
          .toList(),
      shortDescription: map[productFieldShortDescription],
      longDescription: map[productFieldLongDescription],
      salePrice: map[productFieldSalePrice],
      stock: map[productFieldStock],
      avgRating: map[productFieldAvgRating],
      productDiscount: map[productFieldDiscount],
      thumbnailImageUrl: map[productFieldThumbnail],
      additionalImages:
      (map[productFieldImages] as List).map((e) => e.toString()).toList(),
      tags: (map[productFieldTags] as List).map((e) => e.toString()).toList(),
      available: map[productFieldAvailable],
      featured: map[productFieldFeatured],
    );
  }
}
