const String COLLECTION_CATEGORY = 'Category';
const String CATEGORY_FIELD_ID = 'category_id';
const String CATEGORY_FIELD_NAME = 'category_name';
const String CATEGORY_FIELD_PRODUCT_COUNT = 'category_product_count';

class CategoryModel {
  String? categoryId;
  String categoryName;
  num productCount;

  CategoryModel({
    this.categoryId,
    required this.categoryName,
    this.productCount = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CATEGORY_FIELD_ID: categoryId,
      CATEGORY_FIELD_NAME: categoryName,
      CATEGORY_FIELD_PRODUCT_COUNT: CATEGORY_FIELD_PRODUCT_COUNT,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map[CATEGORY_FIELD_ID],
      categoryName: map[CATEGORY_FIELD_NAME],
      productCount: map[CATEGORY_FIELD_PRODUCT_COUNT],
    );
  }
}
