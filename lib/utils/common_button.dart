import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final double? height;
  final void Function()? onPressed;
  final double? labelSize;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final double? buttonRadius;
  final String? labelLogo;
  final Color? buttonBorderColor;
  final double? width;
  final Color? buttonColorGrade;
  final String? img;
  final Color? imgColor;
  final bool? textShadow;
  final double? horizontalPadding;
  final bool? load;

  const CommonButton({
    this.label,
    this.buttonColor,
    this.height,
    this.width,
    this.onPressed,
    this.labelSize,
    this.labelColor,
    this.labelWeight,
    this.buttonRadius,
    this.labelLogo,
    this.buttonBorderColor,
    this.buttonColorGrade,
    this.img,
    this.imgColor,
    this.textShadow,
    this.horizontalPadding,
    this.load,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => buttonColor ?? Colors.blue.withAlpha(10)),
          shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
              side: BorderSide(color: buttonBorderColor ?? Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(buttonRadius ?? 12)),
            ),
          ),
          padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20, vertical: 15),
          ),
          elevation: MaterialStateProperty.resolveWith((states) => 0.0),
        ),
        child: load ?? false
            ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
            : Row(
          mainAxisAlignment: MainAxisAlignment.center, // Ensures centering
          children: [
            if (img != null)
              SvgPicture.asset(
                img!,
                fit: BoxFit.contain,
                color: imgColor,
              ),
            if (img != null && label != null) const SizedBox(width: 10),
            if (label != null)
              Flexible(
                // Changed from Expanded to Flexible for better centering
                child: Text(
                  label!,
                  style: TextStyle(
                    fontSize: labelSize ?? 16,
                    color: labelColor ?? Colors.white,
                    fontWeight: labelWeight ?? FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}