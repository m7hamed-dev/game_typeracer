import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? elevation;
  // final Color? textColor;
  const Btn({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.margin,
    this.width,
    this.elevation,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        onLongPress: () {},
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: elevation ?? .5,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
