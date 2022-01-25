import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.height,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            spreadRadius: 0.0,
            blurRadius: 0.0,
            offset: const Offset(0.2, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
