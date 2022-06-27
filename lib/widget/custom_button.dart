import 'package:flutter/material.dart';

import '../constant.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final Color? textColor;

  final BorderSide? borderSide;
  const CustomButton(
      {Key? key,
      this.onPressed,
      this.textColor,
      this.text,
      this.color,
      this.child,
      this.width = double.infinity,
      this.height,
      this.borderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height ?? 60,
        width: width,
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? primaryColor),
          duration: const Duration(milliseconds: 500),
          child: MaterialButton(
            onPressed: onPressed,
            child: child ??
                Text(text!,
                    style: style.copyWith(color: textColor ?? Colors.white)),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: borderSide ?? BorderSide.none),
          ),
        ),
      ),
    );
  }
}
