import 'package:flutter/material.dart';
import 'package:flyro/export.dart';

class SocialButton extends StatefulWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool? isEnabled;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;

  const SocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.height = 56.0,
    this.width,
    this.borderRadius = 30.0,
    this.isEnabled = true,
    this.iconSize = 20.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: widget.isEnabled == true ? widget.onPressed : null,
      child: Container(
        height: widget.height,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? context.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.iconPath,
              height: widget.iconSize,
              color: widget.iconColor,
            ),
            12.width,
            MyText(
              text: widget.text,
              color: widget.textColor ?? context.text,
              weight: widget.fontWeight,
              size: widget.fontSize,
            ),
          ],
        ),
      ),
    );
  }
}

// Add this to your existing MyTextFieldPresets file or create a new one
extension SocialButtonPresets on SocialButton {
  
  static SocialButton google({
    required BuildContext context,
    required VoidCallback onPressed,
    String text = 'Sign in with Google',
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? height,
    double? width,
    bool? isEnabled,
  }) =>
      SocialButton(
        text: text,
        iconPath: Assets.google,
        onPressed: onPressed,
        backgroundColor: backgroundColor ?? context.surface,
        textColor: textColor ?? context.text,
        iconColor: iconColor,
        height: height,
        width: width,
        isEnabled: isEnabled,
      );

  static SocialButton apple({
    required BuildContext context,
    required VoidCallback onPressed,
    String text = 'Sign in with Apple',
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? height,
    double? width,
    bool? isEnabled,
  }) =>
      SocialButton(
        text: text,
        iconPath: Assets.apple,
        onPressed: onPressed,
        backgroundColor: backgroundColor ?? context.surface,
        textColor: textColor ?? context.text,
        iconColor: iconColor,
        height: height,
        width: width,
        isEnabled: isEnabled,
      );

  static SocialButton facebook({
    required BuildContext context,
    required VoidCallback onPressed,
    String text = 'Sign in with Facebook',
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? height,
    double? width,
    bool? isEnabled,
  }) =>
      SocialButton(
        text: text,
        iconPath: Assets.facebook, // Make sure you have this asset
        onPressed: onPressed,
        backgroundColor: backgroundColor ?? const Color(0xFF1877F2),
        textColor: textColor ?? Colors.white,
        iconColor: iconColor ?? Colors.white,
        height: height,
        width: width,
        isEnabled: isEnabled,
      );

  static SocialButton twitter({
    required BuildContext context,
    required VoidCallback onPressed,
    String text = 'Sign in with Twitter',
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? height,
    double? width,
    bool? isEnabled,
  }) =>
      SocialButton(
        text: text,
        iconPath: Assets.google, // Make sure you have this asset
        onPressed: onPressed,
        backgroundColor: backgroundColor ?? const Color(0xFF1DA1F2),
        textColor: textColor ?? Colors.white,
        iconColor: iconColor ?? Colors.white,
        height: height,
        width: width,
        isEnabled: isEnabled,
      );
}