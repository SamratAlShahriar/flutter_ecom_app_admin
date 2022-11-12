const String collectionDescription = 'Descriptions';
const String descriptionFieldDesTitle = 'description_title';
const String descriptionFieldDescription = 'description';
const String descriptionFieldDesViewOrder = 'description_view_order';

class ProductDescriptionModel {
  String descriptionTitle;
  String description;
  int descriptionViewOrder;

  ProductDescriptionModel(
      {required this.descriptionTitle,
      required this.description,
      required this.descriptionViewOrder});

  factory ProductDescriptionModel.fromMap(Map<String, dynamic> map) {
    return ProductDescriptionModel(
      descriptionTitle: map[descriptionFieldDesTitle],
      description: map[descriptionFieldDescription],
      descriptionViewOrder: map[descriptionFieldDesViewOrder],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      descriptionFieldDesTitle: descriptionTitle,
      descriptionFieldDescription: description,
      descriptionFieldDesViewOrder: descriptionViewOrder,
    };
  }
}
