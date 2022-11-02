import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/models/dashboard_model.dart';

class DashboardItem extends StatelessWidget {
  final DashboardModel model;

  const DashboardItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, model.routeName),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(model.iconData,
                  size: 50, color: Theme.of(context).primaryColor),
              SizedBox(
                height: 10,
              ),
              Text(
                model.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
