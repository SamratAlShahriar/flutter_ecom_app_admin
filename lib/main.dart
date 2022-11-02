import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_admin/firebase_options.dart';
import 'package:flutter_ecom_app_admin/pages/add_product_page.dart';
import 'package:flutter_ecom_app_admin/pages/category_page.dart';
import 'package:flutter_ecom_app_admin/pages/dashboard_page.dart';
import 'package:flutter_ecom_app_admin/pages/launcher_page.dart';
import 'package:flutter_ecom_app_admin/pages/login_page.dart';
import 'package:flutter_ecom_app_admin/pages/order_page.dart';
import 'package:flutter_ecom_app_admin/pages/product_details_page.dart';
import 'package:flutter_ecom_app_admin/pages/product_repurchase_page.dart';
import 'package:flutter_ecom_app_admin/pages/report_page.dart';
import 'package:flutter_ecom_app_admin/pages/settings_page.dart';
import 'package:flutter_ecom_app_admin/pages/user_list_page.dart';
import 'package:flutter_ecom_app_admin/pages/view_product_page.dart';
import 'package:flutter_ecom_app_admin/providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LauncherPage.routeName,
      routes: {
        AddProductPage.routeName: (_) => const AddProductPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        DashboardPage.routeName: (_) => const DashboardPage(),
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        OrderPage.routeName: (_) => const OrderPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        ProductRepurchasePage.routeName: (_) => const ProductRepurchasePage(),
        ReportPage.routeName: (_) => const ReportPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
        UserListPage.routeName: (_) => const UserListPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
