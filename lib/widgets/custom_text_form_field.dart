import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.controller,
    this.hintText,
    this.labelText,
    this.margin,
    this.textInputType = TextInputType.text,
    this.validator,
    this.alignment,
    this.width,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.fontStyle,
    this.isObscureText,
    this.textInputAction,
    this.maxLines,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.variant,
    this.padding,
    this.shape,
    this.prefixText
  });
TextEditingController? controller;

TextFormFieldPadding? padding;

TextInputAction? textInputAction;

bool? isObscureText;

FocusNode? focusNode;

bool readOnly;

Alignment? alignment;

String? hintText;

String? labelText;

String? prefixText;

double? width;

TextFormFieldVariant? variant;

EdgeInsetsGeometry? margin;

TextInputType? textInputType;

FormFieldValidator<String>? validator;

List<TextInputFormatter>? inputFormatters;

VoidCallback? onTap;

TextFormFieldFontStyle? fontStyle;

BoxConstraints? prefixConstraints;

BoxConstraints? suffixConstraints;

TextFormFieldShape? shape;

int? maxLines;

Widget? prefix;

Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

 _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        inputFormatters: inputFormatters,
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      labelText: labelText ?? "",
      prefixText: prefixText ?? "",
      labelStyle: TextStyle(
        color: ColorConstant.black900, // Specify the desired label color
      ),
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT17:
        return getPadding(
          left: 16,
          top: 31,
          right: 16,
          bottom: 31,
        );default:
        return getPadding(
          left: 15,
          top: 17,
          right: 15,
          bottom: 17,
        );
    }
  }


  _setFillColor() {
  switch (variant) {
    case TextFormFieldVariant.OutlineGray900:
      return Colors.transparent; // or any color you prefer
    default:
      return ColorConstant.lightGrey;
  }
}

_setFilled() {
  switch (variant) {
    case TextFormFieldVariant.None:
    case TextFormFieldVariant.OutlineGray900:
      return false;
    default:
      return true;
  }
}


  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray900:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.black900,
            width: 2,
          ),
        );
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder16:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
    }
  }



 _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.Aller14:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Aller',
          fontWeight: FontWeight.w400,
        );
        default:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Aller',
          fontWeight: FontWeight.w400,
        );
    }
  }
}

enum TextFormFieldFontStyle {
  Aller14
}

enum TextFormFieldVariant {
  None,
  FillGray100,
  OutlineGray900,
}

enum TextFormFieldPadding {
  PaddingT17
}

enum TextFormFieldShape { RoundedBorder16, RoundedBorder20, CircleBorder12 }