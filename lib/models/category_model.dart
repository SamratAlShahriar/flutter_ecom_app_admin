const String collectionCategory = 'Category';
const String collectionFieldId = 'category_id';
const String collectionFieldName = 'category_name';
const String collectionFieldProductCount = 'category_product_count';

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
      collectionFieldId: categoryId,
      collectionFieldName: categoryName,
      collectionFieldProductCount: productCount,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map[collectionFieldId],
      categoryName: map[collectionFieldName],
      productCount: map[collectionFieldProductCount],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}
