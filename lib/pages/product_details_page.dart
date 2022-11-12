import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_admin/custom_widgets/additional_image_view_item.dart';
import 'package:flutter_ecom_app_admin/models/product_model.dart';
import 'package:flutter_ecom_app_admin/pages/product_repurchase_page.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:flutter_ecom_app_admin/utils/constants_values.dart';
import 'package:flutter_ecom_app_admin/utils/helper_functions.dart';
import 'package:flutter_ecom_app_admin/utils/widget_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details_page';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;
  late ProductProvider productProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productModel.productName,
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: productModel.thumbnailImageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            height: 100,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productModel.additionalImages.isEmpty
                    ? 1
                    : productModel.additionalImages.length + 1,
                itemBuilder: (context, index) {
                  if (productModel.additionalImages.isNotEmpty &&
                      index < productModel.additionalImages.length) {
                    return AdditionalImageViewItem(
                      child: InkWell(
                        onTap: () {
                          _showImageOnDialog(index);
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: productModel.additionalImages![index],
                          placeholder: (context, url) => const Center(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_sharp,
                            size: 60,
                          ),
                        ),
                      ),
                    );
                  }
                  return AdditionalImageViewItem(
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: _addImage,
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ProductRepurchasePage.routeName,
                        arguments: productModel);
                  },
                  child: Text('Re-purchase')),
              SizedBox(
                width: 16,
              ),
              OutlinedButton(
                  onPressed: () {
                    _showPurchaseList();
                  },
                  child: const Text('Purchase History')),
            ],
          ),
          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title:
                Text('Sale Price : $currencySymbol ${productModel.salePrice}'),
            subtitle: Text(
              'Stock : ${productModel.stock}',
            ),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    hint: 'New Price...',
                    title: 'Update Sale Price',
                    onSubmit: (value) {
                      productProvider
                          .updateProductField(productModel.productId!,
                              productFieldSalePrice, num.parse(value))
                          .then((v) {
                        productModel.salePrice = num.parse(value);
                        setState(() {});
                      });
                    });
              },
              icon: Icon(Icons.edit),
            ),
          ),
          SwitchListTile(
            value: productModel.available,
            onChanged: (value) {
              setState(() {
                productModel.available = value;
              });
              productProvider.updateProductField(
                  productModel.productId!, productFieldAvailable, value);
            },
            title: Text('Available'),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value) {
              setState(() {
                productModel.featured = value;
              });
              productProvider.updateProductField(
                  productModel.productId!, productFieldFeatured, value);
            },
            title: Text('Featured'),
          ),
          if (productModel.descriptions != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descriptions',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productModel.descriptions?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final desM = productModel.descriptions?[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "${desM?.descriptionTitle}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        subtitle: Text("${desM?.description}",
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodySmall),
                      );
                    },
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showPurchaseList() async {
    await productProvider.getAllPurchaseByPurchaseId(productModel.productId!);
    showModalBottomSheet(
        context: context,
        builder: (context) => InkWell(
              onTapDown: (_) {
                Navigator.pop(context);
              },
              child: ListView.builder(
                itemCount: productProvider.purchaseListByProductId.length,
                itemBuilder: (context, index) {
                  final purchaseModel =
                      productProvider.purchaseListByProductId[index];
                  return ListTile(
                    title: Text(getFormattedDate(
                        purchaseModel.dateModel.timestamp.toDate())),
                    subtitle:
                        Text('$currencySymbol ${purchaseModel.purchasePrice}'),
                    trailing: Text('Qty : ${purchaseModel.purchaseQuantity}'),
                  );
                },
              ),
            ));
  }

  void _addImage() async {
    final selectedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (selectedFile != null) {
      EasyLoading.show(status: 'Please wait...');
      try {
        final downloadUrl =
            await productProvider.uploadImage(selectedFile.path);
        final previousList = productModel.additionalImages;
        previousList.add(downloadUrl);
        await productProvider.updateProductField(
            productModel.productId!, productFieldImages, previousList);
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Uploaded!');
        }
        setState(() {});
      } catch (error) {
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Upload Failed!');
        }
        rethrow;
      }
    }
  }

  void _showImageOnDialog(int index) {
    final url = productModel.additionalImages[index];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 2,
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Deleting...');
                      try {
                        await productProvider.deleteImage(url);
                        final tempList = productModel.additionalImages;
                        tempList.removeAt(index);
                        await productProvider.updateProductField(
                          productModel.productId!,
                          productFieldImages,
                          tempList,
                        );
                        EasyLoading.dismiss();

                        setState(() {

                        });
                        if (mounted) {
                          showMsg(context, 'Deleted');
                        }
                      } catch (error) {
                        EasyLoading.dismiss();
                        if (mounted) {
                          showMsg(context, error.toString());
                        }
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 36.0,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
