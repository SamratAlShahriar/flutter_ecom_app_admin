import 'package:flutter/material.dart';

class AdditionalImageViewItem extends StatelessWidget {
  final Widget child;
  const AdditionalImageViewItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),

      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: child,
    );
  }
}
