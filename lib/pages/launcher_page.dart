import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/pages/dashboard_page.dart';
import 'package:flutter_ecom_app_admin/pages/login_page.dart';

import '../database/auth/auth_service.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName = '/';

  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (AuthService.currentUser != null) {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
