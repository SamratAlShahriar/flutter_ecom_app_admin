import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/models/category_model.dart';

import '../utils/helper_functions.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add_product_page';

  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _discountController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? thumbnailImageUrl;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
}
