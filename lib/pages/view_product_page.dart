import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/view_product_page';

  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CategoryModel? categoryModel;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Row(
                children: [
                  Consumer<ProductProvider>(
                    builder: (context, provider, child) =>
                        DropdownButtonFormField<CategoryModel>(
                            hint: const Text('Category : All'),
                            value: categoryModel,
                            isExpanded: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffix: IconButton(
                                onPressed: () {
                                  //TODO: add clear button for all categories
                                },
                                icon: categoryModel != null ? Icon(Icons.close):Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            items: provider.categoryList
                                .map((cModel) =>
                                DropdownMenuItem(
                                    value: cModel,
                                    child: Text(cModel.categoryName)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                categoryModel = value;
                              });
                              if (categoryModel != null) {
                                provider
                                    .getAllProductsByCategory(categoryModel!);
                              } else {
                                provider.getAllProducts();
                              }
                            }),
                  )
                ],
              ),
              provider.productList.isEmpty
                  ? const Center(
                child: Text(
                  'No Product Found!',
                ),
              )
                  : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.productList.length,
                      itemBuilder: (context, index) {
                        final product = provider.productList[index];
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: product.thumbnailImageUrl,
                            width: 60,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Text(product.productName),
                          subtitle: Text(product.category.categoryName),
                          trailing: Text('Stock : ${product.stock}'),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
