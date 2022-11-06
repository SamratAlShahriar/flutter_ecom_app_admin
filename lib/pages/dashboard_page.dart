import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/database/auth/auth_service.dart';
import 'package:flutter_ecom_app_admin/pages/launcher_page.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/dashboard_item.dart';
import '../database/firebase_db_helper.dart';
import '../models/dashboard_model.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard_page';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to populate categories
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();

    return Scaffold(
      body: Scaffold(
          body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          return DashboardItem(
            model: dashboardModelList[index],
          );
        },
      )),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService.logout().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, LauncherPage.routeName));
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
