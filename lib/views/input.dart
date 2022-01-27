import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  //
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final String? emptyMsg;
  final String? hint;
  final String? lableTxt;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? autofocus;
  final bool? isShowBuildCounter;
  final ValueChanged? onChange;
  final Function? changeValueObScureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Color? color;
  final void Function()? onTap;
  final String? prefixText;
  //
  const Input({
    Key? key,
    this.emptyMsg,
    this.textAlign,
    this.hint,
    this.obscureText,
    this.lableTxt,
    this.controller,
    this.maxLines,
    this.maxLength,
    this.onChange,
    this.autovalidateMode,
    this.validator,
    this.margin,
    this.textInputType,
    this.changeValueObScureText,
    this.suffixIcon,
    this.prefixIcon,
    this.height,
    this.contentPadding,
    this.textStyle,
    this.onFieldSubmitted,
    this.color,
    this.fontSize,
    this.onTap,
    this.autofocus,
    this.isShowBuildCounter,
    this.prefixText,
  }) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    //
    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      maxLength: maxLength ?? 80,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,

      textAlign: textAlign ?? TextAlign.center,
      // textDirection: TextDirection.rtl,
      // buildCounter: (BuildContext context,
      //     {int? currentLength, int? maxLength, bool? isFocused}) {
      //   return isShowBuildCounter == true
      //       ? myTinyString(currentLength.toString())
      //       : null;
      // },
      // buildCounter: (BuildContext context,
      //         {int currentLength, int maxLength, bool isFocused}) =>
      //     null,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: validator,
      // validator: validator ?? ValidatorClass.generalValidation,
      onChanged: onChange,
      style: txtStyle(context),
      onTap: onTap ?? () {},
      autocorrect: false,
      decoration: InputDecoration(
        prefixText: prefixText ?? '',
        // suffixText: 'suffixText',
        prefixStyle: txtStyle(context),
        hintText: hint, //0900000088 5837
        hintStyle: hinStyle(context),
        // error
        errorStyle: errorStyle(context),
        focusedErrorBorder: OutlineInputBorder(
          // gapPadding: 40,
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),

        contentPadding: contentPadding,
        // fillColor: HexColor('##fef1f4'),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.8),
            width: 0.6,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            // color: HexColor('#f8f8f8'),
            width: 2.0,
          ),
        ),
      ),
    );
  }

  TextStyle txtStyle(context) {
    return TextStyle(
        // fontSize: ScreenUtil.setSize(context, 18.0),
        );
  }

  TextStyle hinStyle(context) {
    return TextStyle(
      // fontSize: ScreenUtil.setSize(context, 18.0),
      color: Colors.grey,
    );
  }

  TextStyle errorStyle(context) {
    return TextStyle(
      // fontSize: ScreenUtil.setSize(context, 15.0),
      color: Colors.red,
    );
  }
}
