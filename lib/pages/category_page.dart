import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:flutter_ecom_app_admin/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category_page';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
              context: context,
              title: 'Category',
              onSubmit: (value) {
                Provider.of<ProductProvider>(context, listen: false)
                    .addNewCategory(value);
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return provider.categoryList.isEmpty
              ? const Center(
                  child: Text('No Categories Found!'),
                )
              : ListView.builder(
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, index) {
                    final catModel = provider.categoryList[index];

                    return ListTile(
                      title: Text(catModel.categoryName),
                      trailing: Text('Total : ${catModel.productCount}'),
                    );
                  },
                );
        },
      ),
    );
  }
}
