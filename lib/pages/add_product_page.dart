import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';
import 'package:flutter_ecom_app_admin/models/date_model.dart';
import 'package:flutter_ecom_app_admin/models/product_description_model.dart';
import 'package:flutter_ecom_app_admin/models/product_model.dart';
import 'package:flutter_ecom_app_admin/models/purchase_model.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/helper_functions.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add_product_page';

  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late ProductProvider _productProvider;

  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _discountController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? thumbnailImagePath;
  CategoryModel? categoryModel;
  DateTime? purchaseDate;
  late StreamSubscription<ConnectivityResult> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    // TODO: implement initState

    isConnectedToInternet().then((value) {
      setState(() {
        _isConnected = value;
      });
    });

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile;
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            if (!_isConnected)
              const ListTile(
                tileColor: Colors.red,
                title: Text(
                  'No Internet Connectivity',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: thumbnailImagePath == null
                          ? const Icon(
                              Icons.photo,
                              size: 100,
                            )
                          : Image.file(
                              File(thumbnailImagePath!),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            _getImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Open Camera'),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _getImage(ImageSource.gallery);
                          },
                          icon: const Icon(Icons.photo_album),
                          label: const Text('Open Gallery'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, child) =>
                  DropdownButtonFormField<CategoryModel>(
                      hint: const Text('Select Category'),
                      value: categoryModel,
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      items: provider.categoryList
                          .map((cModel) => DropdownMenuItem(
                              value: cModel, child: Text(cModel.categoryName)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryModel = value;
                        });
                      }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Product Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                maxLines: 2,
                controller: _shortDescriptionController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Short Description(optional)',
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                maxLines: 3,
                controller: _longDescriptionController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Long Description(optional)',
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _purchasePriceController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Purchase Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (num.parse(value) <= 0) {
                    return 'Price should be greater than 0';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _salePriceController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Sale Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (num.parse(value) <= 0) {
                    return 'Price should be greater than 0';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _quantityController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Quantity',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (num.parse(value) <= 0) {
                    return 'Quantity should be greater than 0';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _discountController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter Discount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (num.parse(value) < 0) {
                    return 'Discount should not be a negative value';
                  }
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: _selectDate,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Select Purchase Date'),
                    ),
                    Text(purchaseDate == null
                        ? 'No date chosen'
                        : getFormattedDate(purchaseDate!)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _shortDescriptionController.dispose();
    _longDescriptionController.dispose();
    _purchasePriceController.dispose();
    _salePriceController.dispose();
    _discountController.dispose();
    _quantityController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _selectDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        purchaseDate = date;
      });
    }
  }

  void _getImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 70,
      maxWidth: 720,
      maxHeight: 720,
    );
    if (pickedImage != null) {
      setState(() {
        thumbnailImagePath = pickedImage.path;
      });
    }
  }

  void _saveProduct() async {
    if (thumbnailImagePath == null) {
      showMsg(context, 'Please select a product image');
      return;
    }
    if (purchaseDate == null) {
      showMsg(context, 'Please select a purchase date');
    }
    if (_formKey.currentState!.validate()) {
      String? downloadUrl;
      EasyLoading.show(status: 'Please wait');

      try {
        downloadUrl = await _productProvider.uploadImage(thumbnailImagePath!);

        final productModel = ProductModel(
          productName: _nameController.text,
          shortDescription: _shortDescriptionController.text.isEmpty
              ? null
              : _shortDescriptionController.text,
          descriptions: <ProductDescriptionModel>[
            ProductDescriptionModel(
                descriptionTitle: 'descriptionTitle1',
                description: 'description1',
                descriptionViewOrder: 1),
            ProductDescriptionModel(
                descriptionTitle: 'descriptionTitle2',
                description: 'description2',
                descriptionViewOrder: 2),
          ],
          longDescription: _longDescriptionController.text.isEmpty
              ? null
              : _longDescriptionController.text,
          category: categoryModel!,
          productDiscount: num.parse(_discountController.text),
          salePrice: num.parse(_salePriceController.text),
          stock: num.parse(_quantityController.text),
          thumbnailImageUrl: downloadUrl,
        );

        final purchaseModel = PurchaseModel(
          purchaseQuantity: num.parse(_quantityController.text),
          purchasePrice: num.parse(_purchasePriceController.text),
          dateModel: DateModel(
            timestamp: Timestamp.fromDate(purchaseDate!),
            day: purchaseDate!.day,
            month: purchaseDate!.month,
            year: purchaseDate!.year,
          ),
        );

        await _productProvider.addNewProduct(productModel, purchaseModel);
        EasyLoading.dismiss();

        if (mounted) {
          showMsg(context, 'Product Saved!');
        }

        _resetField();
      } catch (error) {
        if (downloadUrl != null) {
          await _productProvider.deleteImage(downloadUrl);
        }
        if (mounted) showMsg(context, 'Something went wrong');
        EasyLoading.dismiss();
      }
    }
  }

  void _resetField() {
    setState(() {
      _nameController.clear();
      _shortDescriptionController.clear();
      _longDescriptionController.clear();
      _purchasePriceController.clear();
      _salePriceController.clear();
      _discountController.clear();
      _quantityController.clear();
      categoryModel = null;
      purchaseDate = null;
      thumbnailImagePath = null;
    });
  }
}
