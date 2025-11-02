import 'package:firebase_complete/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CommonTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final TextEditingController? con;
  final bool? readOnly;
  final bool? enable;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool? isDense;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final String? labelText;
  final Widget? suffix;
  final Color? suffixColor;
  final Color? fillColor;
  final void Function()? suffixOnTap;
  final Widget? prefixIcon;
  final double? constraintHeight;
  final TextStyle? labelStyle;
  final String? hintText;
  final String? headerLabel;
  final TextStyle? hintStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? style;
  final double? borderRadius;
  final Color? borderColor;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? cursorHeight;
  final FocusNode? focusNode;

  const CommonTextField({
    super.key,
    this.keyBoardType,
    this.con,
    this.validator,
    this.readOnly,
    this.enable,
    this.onTap,
    this.inputFormatters,
    this.obscureText,
    this.isDense,
    this.onEditingComplete,
    this.onChanged,
    this.labelText,
    this.suffix,
    this.suffixColor,
    this.fillColor,
    this.suffixOnTap,
    this.prefixIcon,
    this.constraintHeight,
    this.labelStyle,
    this.hintText,
    this.headerLabel,
    this.hintStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.style,
    this.borderRadius,
    this.borderColor,
    this.border,
    this.contentPadding,
    this.height,
    this.cursorHeight,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerLabel != null) ...[
          Text(
            headerLabel ?? "",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            controller: con,
            keyboardType: keyBoardType,
            validator: validator,
            readOnly: readOnly ?? false,
            onTap: onTap,
            enabled: enable ?? true,
            obscureText: obscureText ?? false,
            inputFormatters: inputFormatters,
            cursorColor: AppColors.green,
            cursorErrorColor: Colors.red,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            cursorHeight: cursorHeight,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: style,
            focusNode: focusNode ?? FocusNode(),
            decoration: InputDecoration(
              fillColor: fillColor,
              contentPadding: contentPadding,
              filled: fillColor != null ? true : false,
              constraints: BoxConstraints(maxHeight: constraintHeight ?? double.infinity),
              isDense: true,
              hintText: hintText,
              hintStyle: hintStyle,
              labelStyle: labelStyle,
              labelText: labelText,
              prefixIcon: prefixIcon,
              focusedBorder: focusedBorder ??
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    borderSide: BorderSide(color: AppColors.black.withOpacity(0.1)),
                  ),
              enabledBorder: enabledBorder ??
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    borderSide: BorderSide(color: borderColor ?? AppColors.black.withOpacity(0.1)),
                  ),
              disabledBorder: disabledBorder ??
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    borderSide: BorderSide(color: AppColors.black.withOpacity(0.05)),
                  ),
              errorBorder: errorBorder ??
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
              focusedErrorBorder: focusedErrorBorder ??
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
              suffixIcon: suffix != null
                  ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(onTap: suffixOnTap, child: suffix),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}